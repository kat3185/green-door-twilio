require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require "sinatra/activerecord"
require 'pry'

class Game < ActiveRecord::Base
end

def find_game(text)
  game_list = Array.new
  Game.all.each do |game|
    if game.short_title.downcase.include?(text.downcase)
      game_list << game
    end
  end
  game_list
end

def create_response(games, text)
  if games.empty?
    "I'm sorry, I don't know that game!"
  elsif games.length == 1
    "Visit #{games.first.url} to play #{games.first.title}.  Enjoy!"
  elsif games.length == 2
    "If you are looking for #{games.first.title}, visit #{games.first.url}, if you meant #{games.second.title}, visit #{games.second.url}"
  else
    "I know several games that have #{text} in them.  Could you be more specific?"
  end
end

binding.pry

get '/sms-quickstart' do

  body = params[:Body]

  games = find_game(body)

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message create_response(games, body)
  end

  twiml.text
end

get '/games' do
  game_list = Game.all
  erb :index, locals: {game_list: game_list}
end

post "/games" do
  new_game = Game.new(params[:game])

  if new_game.save
    redirect "/games"
  else
    erb :index, locals: { game: game }
  end
end