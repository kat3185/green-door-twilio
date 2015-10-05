require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'pry'

get '/sms-quickstart' do

  projects = { "NSS" => "http://www.newschoolswing.com",
               "BSC" => "http://www.bostonswingcentral.org"}
  body = params[:Body]

  if projects[body] == nil
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "I'm sorry, I don't know that game!"
    end
  else
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "#{projects[body]}\n Have fun playing #{body}!"
    end
  end
  twiml.text
end
