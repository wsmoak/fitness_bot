# FitnessBot

Slack bot inspired by https://github.com/brandonshin/slackbot-workout

At intervals, it calls out a random exercise for a random person in the #fitness channel.

## References

* http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/
* https://api.slack.com/methods/channels.info
* https://groups.google.com/forum/#!topic/elixir-lang-talk/LqSYkKBkx1U

## Installation

clone the git repo

configure environment variables or modify config/prod.exs

MIX_ENV=prod iex -S mix

## Environments

With MIX_ENV=test, it uses mock Slack and Slackbot clients

With MIX_ENV=dev, (the default,) it uses the real Slack client to read data, but the mock Slackbot client so that it does not actually send the messages to Slack

With MIX_ENV=prod, it uses the real Slack and Slackbot clients to read and post
