defmodule FitnessBot.SlackbotClient do
  use HTTPoison.Base
  require Logger

  @team Application.get_env(:fitness_bot, :slack_team_name)
  @token Application.get_env(:fitness_bot, :slack_url_token)

  def send_message(channel, text) do
    url = "https://"<>@team<>".slack.com/services/hooks/slackbot?token="<>@token<>"&channel=%23"<>channel
    Logger.debug "Sending #{text} to #{url}"
    post!(url, text)
  end

end
