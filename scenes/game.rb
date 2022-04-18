module Scene
  class Game
    ENEMY_FREQUENCY = 0.05

    def initialize(window)
      @window = window
      @player = Player.new(window)
      @enemies = []
      @bullets = []
      @explosions = []
    end

    def button_down(id)
      @bullets.push @player.fire if id == Gosu::KB_SPACE or id == Gosu::GP_BUTTON_7
    end

    def update
      create_enemy
      process_player_input

      # move
      @player.move
      @enemies.each {|enemy| enemy.move }
      @bullets.each {|bullet| bullet.move }

      handle_colisions

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

    def create_enemy
      @enemies.push Enemy.new(@window) if rand < ENEMY_FREQUENCY
    end

    def handle_colisions
      @enemies.dup.each do |enemy|
        if hit_bullet = enemy.got_hit_by(@bullets) || hit_explosion = enemy.got_hit_by(@explosions)
          @enemies.delete enemy
          @bullets.delete hit_bullet
          @explosions.delete hit_explosion
          @explosions.push Explosion.new(@window, enemy.x, enemy.y)
        end
      end
    end

    def process_player_input
      @player.turn_left if @window.button_down?(Gosu::KB_LEFT) or @window.button_down?(Gosu::GP_LEFT)
      @player.turn_right if @window.button_down?(Gosu::KB_RIGHT) or @window.button_down?(Gosu::GP_RIGHT)
      @player.acelerate if @window.button_down?(Gosu::KB_UP) or @window.button_down?(Gosu::GP_BUTTON_0)
    end
  end
end
