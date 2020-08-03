# frozen_string_literal: true

require 'curses'
require_relative './page_data'

module Display
  def self.output_data
    init_screen
    build_output
  end

  def self.init_screen
    Curses.init_screen
    Curses.curs_set(0) # Invisible cursor
  end

  def self.build_output
    @window = Curses.stdscr
    @window.clear
    @window.setpos(0, 0)
    @window.addstr(PageData.like_quantity)
    @window.nodelay = true
    @window.refresh
  end
end
