use Mix.Config

IO.puts "IN DEV MODE!"

config :fitness_bot, :slack_client, FitnessBot.SlackClient
config :fitness_bot, :slackbot_client, FitnessBot.SlackbotClient.InMemory

config :fitness_bot, :slack_team_name, "example"
config :fitness_bot, :slack_user_token, System.get_env("SLACK_USER_TOKEN")
config :fitness_bot, :slack_url_token, "example"
