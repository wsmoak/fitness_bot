defmodule FitnessBot.SlackClient do
  use HTTPoison.Base

  @slack_api "https://slack.com/api"
  @token Application.get_env(:fitness_bot, :slack_user_token)

  def get_channel_id_by_channel_name(channel_name) do
    response = list_channels()
    get_channel(response,channel_name)["id"]
  end

  def get_members_by_channel_name(channel_name) do
    response = list_channels()
    get_channel(response,channel_name)["members"]
  end

  def get_user_name_by_user_id(user_id) do
    user_id |> get_user_info |> get_user_name
  end

  def list_channels() do
    endpoint = "channels.list"

    url = @slack_api<>"/"<>endpoint<>"?token="<>@token

    get!(url)
  end

  def get_channel(response, channel_name) do
    decoded_body = response.body |> Poison.decode!
    Enum.find( decoded_body["channels"], fn x -> x["name"] == channel_name end )
  end

  def get_user_name(response) do
    decoded_body = response.body |> Poison.decode!
    decoded_body["user"]["name"]
  end

  def get_user_info(user_id) do
    endpoint = "users.info"

    url = @slack_api<>"/"<>endpoint<>"?token="<>@token<>"&user="<>user_id

    get!(url)
  end

end
