require 'haml'
require 'sinatra'
require 'logger'
require 'json'
require 'mail'

module Tayo
  module Logger
    LOGGER = ::Logger.new(STDOUT)
    LOGGER.level = ::Logger::INFO

    def log
      LOGGER
    end
  end

  class Application
    include Logger

    def initialize
      log.info("Yo mama...")
    end
  end
end

get '/' do
  @tayo = Tayo::Application.new
  haml :sup
end

get '/blah' do
  haml :yoyo
end

get '/json' do
  content_type :json
  { :id => '1', :value => 'matty_b' }.to_json
end

get '/send_email' do
  smtp_conn = Net::SMTP.new('smtp.gmail.com', 587)
  smtp_conn.enable_starttls
  smtp_conn.start('smtp.gmail.com', 'scripts@matthewblair.net', 'changethis', :plain)

  Mail.defaults do
    delivery_method :smtp_connection, { :connection => smtp_conn }
  end

  Mail.deliver do
    to 'me@matthewblair.net'
    from 'scripts@matthewblair.net'
    subject 'testing the mail gem'
    body 'hello'
  end
end

__END__

@@ sup
Hello Matt!

@@ yoyo
Hello Morgan!
