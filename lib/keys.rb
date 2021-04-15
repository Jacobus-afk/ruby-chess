# frozen_string_literal: true

# https://gist.github.com/acook/4190379

require 'io/console'

# module keypress
module Keypress
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  def read_single_key
    c = _read_char

    case c
    when "\r" then :enter
    when "\n" then puts 'LINE FEED'
    when "\e" then :escape
    when "\e[A" then :move_up
    when "\e[B" then :move_down
    when "\e[C" then :move_right
    when "\e[D" then :move_left
    when "\u0003"
      puts 'CONTROL-C'
      exit 0
    else
      puts "SOMETHING ELSE: #{c.inspect}"
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity

  private

  def _get_esc(input)
    return unless input == "\e"

    begin
      input << STDIN.read_nonblock(2)
    rescue StandardError
      nil
    end
  end

  def _read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    _get_esc(input)

    input
  ensure
    STDIN.echo = true
    STDIN.cooked!
  end
end

if __FILE__ == $PROGRAM_NAME
  # include Keypress

  t1 = read_single_key
  puts t1
  t2 = read_single_key
  puts t2
  test = gets
  puts test
end
