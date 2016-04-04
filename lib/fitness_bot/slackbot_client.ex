defmodule FitnessBot.SlackbotClient do
  use HTTPoison.Base
  require Logger

  def send_message(channel, text) do
    token = System.get_env("SLACK_URL_TOKEN_STRING")
    team = System.get_env("SLACK_TEAM_NAME")
    url = "https://"<>team<>".slack.com/services/hooks/slackbot?token="<>token<>"&channel=%23"<>channel
    Logger.debug "Sending #{text} to #{url}"
    post!(url, text)
  end

end
