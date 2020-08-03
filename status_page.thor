# frozen_string_literal: true

require_relative './lib/counter'

class LikeCounter < Thor
  desc 'live',
       'pulls the page and displays the counter'

  def live
    Counter.display_likes
  end
end
