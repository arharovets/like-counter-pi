# frozen_string_literal: true

require 'nokogiri'
require 'faraday'
require 'gemoji'

module PageData
  def self.like_quantity
    response = Nokogiri::HTML(
      Faraday.get('https://www.facebook.com/TucanoCoffeeBali').body
    )
    likes = response.css('a._5sqs').text.chars.map { |letter| letter[/\d+/] }.compact.join

    Emoji.find_by_alias('+1').raw + likes
  end
end
