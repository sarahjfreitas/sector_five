require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'enemy'

class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super(800,600)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemy = Enemy.new(self)
  end

  def update
    @player.turn_left if button_down?(Gosu::KB_LEFT) or button_down?(Gosu::GP_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT) or button_down?(Gosu::GP_RIGHT)
    @player.acelerate if button_down?(Gosu::KB_UP) or button_down?(Gosu::GP_BUTTON_0)
    @player.move
    @enemy.move
  end

  def draw
    @player.draw
    @enemy.draw
  end
end

window = SectorFive.new
window.show
