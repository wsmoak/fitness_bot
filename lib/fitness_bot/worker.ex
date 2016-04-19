defmodule FitnessBot.Worker do
  require Logger
  use GenServer
  use Timex

  @slack_client Application.get_env(:fitness_bot, :slack_client)
  @slackbot_client Application.get_env(:fitness_bot, :slackbot_client)

  @delay_range 30..45

  @channel "fitness"

  @exercises ["10 PUSHUPS", "45 SECOND WALL SIT", "20 JUMPING JACKS", "20 CRUNCHES", "30 SECOND PLANK", "15 SQUATS"]

  @active_days 1..5 # Monday to Friday
  @active_hours 10..15 # 10:00 AM to 3:59 PM

  ## Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  ## Server Callbacks

  def init(:ok) do
    Process.send_after(self, :schedule_next, 5 * 1000)
    {:ok, %{last_user: nil} }
  end

  def handle_info(:call_out, state) do
    members = @slack_client.get_members_by_channel_name(@channel)
    members = Enum.filter(members,fn x -> x != state.last_user end)
    member_count = Enum.count(members)
    member_selection = Enum.random(0..member_count-1)
    user_id = Enum.at( members, member_selection )
    state = Map.put(state, :last_user, user_id)
    user_name = @slack_client.get_user_name_by_user_id(user_id)

    exercise_count = Enum.count(@exercises)
    exercise_selection = Enum.random(0..exercise_count-1)
    exercise = Enum.at(@exercises, exercise_selection)

    exercise_msg = "#{exercise} RIGHT NOW @#{user_name}"
    Logger.info exercise_msg
    @slackbot_client.send_message(@channel, exercise_msg)

    Process.send_after(self, :schedule_next, 5 * 1000 )
    {:noreply, state}
  end

  def handle_info(:schedule_next, state) do
    delay = Enum.random(@delay_range)
    next_time = DateTime.now("America/New_York") |> Timex.shift(minutes: delay)
    next_day = Timex.weekday next_time
    next_hour = next_time.hour
    schedule_next(delay,next_day,next_hour)
    {:noreply, state}
  end

  defp schedule_next(delay,day,hour) when day in @active_days and hour in @active_hours do
    delay_msg = "Next lottery is in #{delay} minutes"
    Logger.info delay_msg
    @slackbot_client.send_message(@channel, delay_msg)
    Process.send_after(self, :call_out, delay * 60 * 1000 )
  end

  defp schedule_next(delay,_,_) do
    Logger.info "Not within active days and times... re-scheduling in #{delay} minutes"
    Process.send_after(self, :schedule_next, delay * 60 * 1000 )
  end

end
