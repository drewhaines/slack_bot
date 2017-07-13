class Bot < SlackRubyBot::Bot
  @id = 0

  # client = Slack::Web::Client.new
  # client.auth_test
  # client.chat_postMessage(channel: '#general', text: 'Hello World', as_user: true)

  def self.next_id
    @id = @id % 10 + 1
  end

  help do
    title 'Bot Boy'
    desc 'This bot helps log data for the Monday Morning Meetings.'

    command 'ping' do
      desc 'Responds with "pong" to let you know Bot Boy is running.'
    end

    command 'hi' do
      desc 'Bot Boy politely says hello.'
    end

    command 'say <expression>' do
      desc 'Bot Boy repeats your expression and logs it at https://fairbot.herokuapp.com.'
    end

    command 'time' do
      desc 'Bot Boy tells you the time (Pacific Timezone).'
    end

    command 'gif me <expression>' do
      desc 'Bot Boy responds with a gif for your expression.'
    end
  end


  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end

  command 'say' do |client, data, match|
    binding.pry
    Rails.cache.write next_id, { text: match['expression'] }
    client.say(channel: data.channel, text: match['expression'])
  end

  command 'time' do |client, data, match|
    client.say(channel: data.channel, text: Time.now.to_s)
  end

  command 'gif me' do |client, data, match|
    client.say(channel: data.channel, text: "Here is your gif for " + match['expression'].to_s, gif: match['expression'])
  end
end
