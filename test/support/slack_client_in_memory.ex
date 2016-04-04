defmodule FitnessBot.SlackClient.InMemory do

  def get_members_by_channel_name(_channel_name) do
    ["ABC123","DEF456","GHI789"]
  end

  def get_user_name_by_user_id("ABC123") do
    "susan"
  end

  def get_user_name_by_user_id("DEF456") do
    "jason"
  end

  def get_user_name_by_user_id("GHI789") do
    "mary"
  end

end
