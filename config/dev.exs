use Mix.Config

IO.puts "IN DEV MODE!"

config :fitness_bot, :slack_client, FitnessBot.SlackClient
config :fitness_bot, :slackbot_client, FitnessBot.SlackbotClient.InMemory
