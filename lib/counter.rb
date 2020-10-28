# frozen_string_literal: true

require_relative './counter/display.rb'

module Counter
  def self.display_likes
    thr = Thread.new do
      loop do
        Display.output_data
        sleep(300)
      rescue Faraday::ConnectionFailed, SocketError, Faraday::ClientError
        retry
      end
    end
    thr.join
  end
end
