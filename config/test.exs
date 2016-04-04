use Mix.Config

IO.puts "IN TEST MODE!!!"

config :fitness_bot, :slack_client, FitnessBot.SlackClient.InMemory
config :fitness_bot, :slackbot_client, FitnessBot.SlackbotClient.InMemory

config :fitness_bot, :slack_team_name, "example"
config :fitness_bot, :slack_user_token, "example"
config :fitness_bot, :slack_url_token, "example"
