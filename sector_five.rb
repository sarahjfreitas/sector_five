require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'enemy'

class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.05

  def initialize
    super(800,600)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemies = []
  end

  def update
    move_player
    create_enemy
    @enemies.each {|enemy| enemy.move }
  end

  def draw
    @player.draw
    @enemies.each {|enemy| enemy.draw }
  end

  private

  def move_player
    @player.turn_left if button_down?(Gosu::KB_LEFT) or button_down?(Gosu::GP_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT) or button_down?(Gosu::GP_RIGHT)
    @player.acelerate if button_down?(Gosu::KB_UP) or button_down?(Gosu::GP_BUTTON_0)
    @player.move
  end

  def create_enemy
    @enemies.push Enemy.new(self) if rand < ENEMY_FREQUENCY
  end
end

window = SectorFive.new
window.show
