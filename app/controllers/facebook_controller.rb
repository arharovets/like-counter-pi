class FacebookController < ApplicationController
  def index
    response = Nokogiri::HTML(HTTParty.get('https://facebook.com/TucanoCoffeeBali'))
    @likes = response.css("a._5sqs")
                     .text
                     .chars
                     .map { |letter| letter[/\d+/] }
                     .compact
                     .join
  end
end
