module Scene
  class Game
    ENEMY_FREQUENCY = 0.05
    MAX_ENEMIES = 100

    def initialize(window)
      @window = window
      @player = Player.new(window)
      @enemies = []
      @bullets = []
      @explosions = []
      @score = {enemies_appeared: 0, enemies_destroyed: 0}
      @game_music = Gosu::Song.new('sounds/Cephalopod.ogg')
      @game_music.play(true)
      @explosion_sound = Gosu::Sample.new('sounds/explosion.ogg')
      @shooting_sound = Gosu::Sample.new('sounds/shoot.ogg')
    end

    def button_down(id)
      if id == Gosu::KB_SPACE or id == Gosu::GP_BUTTON_7
        @bullets.push @player.fire
        @shooting_sound.play(0.3)
      end
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
      @window.change_scene(:end,:count_reached,@score) if @score[:enemies_appeared] >= MAX_ENEMIES
      @window.change_scene(:end,:hit_top,@score) if @player.hit_top?
    end

    def draw
      @player.draw
      @enemies.each {|enemy| enemy.draw }
      @bullets.each {|bullet| bullet.draw }
      @explosions.each { |explosion| explosion.draw }
    end

    private

    def create_enemy
      if rand < ENEMY_FREQUENCY
        @enemies.push Enemy.new(@window)
        @score[:enemies_appeared] += 1
      end
    end

    def handle_colisions
      @enemies.dup.each do |enemy|
        if hit_bullet = enemy.got_hit_by(@bullets) || hit_explosion = enemy.got_hit_by(@explosions)
          @enemies.delete enemy
          @bullets.delete hit_bullet
          @explosions.delete hit_explosion
          @explosions.push Explosion.new(@window, enemy.x, enemy.y)
          @explosion_sound.play
          @score[:enemies_destroyed] += 1
        end
        if enemy.got_hit_by(@player)
          @window.change_scene(:end,:hit_by_enemy,@score)
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
