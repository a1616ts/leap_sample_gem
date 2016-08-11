$:.unshift "../lib"

require 'leap-motion-ws'
require 'selenium-webdriver'

class LeapTest < LEAP::Motion::WS
  def on_connect
    puts "Connect"
    @driver = nil
    @y = 0
  end

  def on_frame frame
    puts "Frame ##{frame.id}, timestamp: #{frame.timestamp}, hands: #{frame.hands.size}, pointables: #{frame.pointables.size}"
    frame.gestures.each do |gesture|
      puts "  -> #{gesture.type} / #{gesture.state}"
      if frame.hands.size == 1 && 5 == frame.pointables.size
        @driver = Selenium::WebDriver.for :firefox if @driver == nil
      end
      if gesture.instance_variable_defined?(:@direction)
        if gesture.direction[0] != nil && 0 < gesture.direction[0]
          puts frame.pointables.size
          case frame.pointables.size
          when 1..3 then
            url = 'https://ja.wikipedia.org/wiki/メインページ'
          # when 2 then
          #   url = 'http://www.aiit.ac.jp/'
          # when 3 then
          #   url = 'https://news.google.co.jp'
          when 4 then
            url = 'http://www.rubylife.jp/install/'
          when 5 then
            url = 'http://www.ink.or.jp/~bigblock/html/start_o.html'
          end
          @driver.navigate.to url if @driver && @driver.current_url != url
        end
        if gesture.direction[1] != nil && 0 != gesture.direction[1]
          y = 0 < gesture.direction[1] ? @y -= 100 : @y += 100
          @driver.execute_script("window.scrollTo(0, #{@y});") if @driver
        end
      end
    end
    if frame.hands.size == 0
      @driver.quit if @driver
      @driver = nil
    end
  end

  def on_disconnect
    puts "disconect"
    stop
  end
end

leap = LeapTest.new(:enable_gesture => true)

Signal.trap("TERM") do
  puts "Terminating..."
  leap.stop
end
Signal.trap("INT") do
  puts "Terminating..."
  leap.stop
end

leap.start
