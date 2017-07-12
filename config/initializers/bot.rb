require File.join(Rails.root, 'bot/tattletale')

SlackRubyBot.configure do |config|
  config.send_gifs = true
end
