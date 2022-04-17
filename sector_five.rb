require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.05

  def initialize
    super(800,600)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
  end

  def update
    # create stuff
    process_player_input
    create_enemy

    # move
    @player.move
    @enemies.each {|enemy| enemy.move }
    @bullets.each {|bullet| bullet.move }

    handle_colision

    # clean up
    @bullets.delete_if { |bullet| bullet.off_screen? }
    @explosions.delete_if { |explosion| explosion.finished? }
    @enemies.delete_if { |enemy| enemy.off_screen? }
  end

  def draw
    @player.draw
    @enemies.each {|enemy| enemy.draw }
    @bullets.each {|bullet| bullet.draw }
    @explosions.each { |explosion| explosion.draw }
  end

  private

  def process_player_input
    @player.turn_left if button_down?(Gosu::KB_LEFT) or button_down?(Gosu::GP_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT) or button_down?(Gosu::GP_RIGHT)
    @player.acelerate if button_down?(Gosu::KB_UP) or button_down?(Gosu::GP_BUTTON_0)
    @bullets.push @player.fire if button_down?(Gosu::KB_SPACE) or button_down?(Gosu::GP_BUTTON_7)
  end

  def create_enemy
    @enemies.push Enemy.new(self) if rand < ENEMY_FREQUENCY
  end

  def handle_colision
    @bullets.dup.each do |bullet|
      @enemies.dup.each do |enemy|
        distance = Gosu::distance(enemy.x, enemy.y, bullet.x, bullet.y)
        if distance <= enemy.radius + bullet.radius # bullet hit enemy
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push Explosion.new(self, enemy.x, enemy.y)
        end
      end
    end
  end
end

window = SectorFive.new
window.show
