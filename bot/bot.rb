class Bot < SlackRubyBot::Bot
  @id = 0

  def self.next_id
    @id = @id % 10 + 1
  end

  help do
    title 'Fairway Bot'
    desc 'This bot does various things that make life at Fairway easier. =)'

    command 'ping' do
      desc 'Responds with "pong" to let you know Fairway Bot is running.'
    end

    command 'hi' do
      desc 'Fairway Bot politely says hello.'
    end

    command 'say <expression>' do
      desc 'Fairway Bot repeats your expression and logs it at https://fairbot.herokuapp.com.'
    end

    command 'time' do
      desc 'Fairway Bot tells you the time (Pacific Timezone).'
    end

    command 'gif me <expression>' do
      desc 'Fairway Bot responds with a gif for your expression.'
    end
  end


  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end

  command 'say' do |client, data, match|
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
