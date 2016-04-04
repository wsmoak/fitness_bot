use Mix.Config

config :fitness_bot, :slack_client, FitnessBot.SlackClient
config :fitness_bot, :slackbot_client, FitnessBot.SlackbotClient

config :fitness_bot, :slack_team_name, System.get_env("SLACK_TEAM_NAME")
config :fitness_bot, :slack_user_token, System.get_env("SLACK_USER_TOKEN")
config :fitness_bot, :slack_url_token, System.get_env("SLACK_URL_TOKEN")
