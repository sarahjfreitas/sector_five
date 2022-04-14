require_relative 'player'
require 'gosu'

class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super(800,600)
    self.caption = 'Sector Five'
    @player = Player.new(self)
  end

  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.acelerate if button_down?(Gosu::KbUp)
    @player.move
  end

  def draw
    @player.draw
  end
end

window = SectorFive.new
window.show
