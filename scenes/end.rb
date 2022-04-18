module Scene
  class End
    def initialize(window,mode,score)
      @window = window
      @score = score
      @bottom_message = "Press ENTER to play again, or ESC to quit."
      @message_font = Gosu::Font.new(28)

      case mode
      when :count_reached
        message_count_reached
      when :hit_by_enemy
        message_hit_by_enemy
      when :hit_top
        message_hit_top
      end

      @end_music = Gosu::Song.new('sounds/FromHere.ogg')
      @end_music.play(true)
    end

    def button_down(id)
      if id ==  Gosu::KB_ENTER || id == Gosu::KB_RETURN
        @window.change_scene(:start)
      elsif id == Gosu::KB_ESCAPE
        @window.close
      end
    end

    def update
    end

    def draw
      @message_font.draw_text(@message,40,40,1,1,1,Gosu::Color::WHITE)
      @message_font.draw_text(@message2,40,75,1,1,1,Gosu::Color::WHITE)
      @message_font.draw_text(@bottom_message,180,540,1,1,1,Gosu::Color::WHITE)
    end

    private

    def background_image
      @_background_image ||= Gosu::Image.new('images/start_screen.png')
    end

    def message_hit_by_enemy
      @message = "You were struck by an enemy ship."
      @message2 = "Before your ship was destroyed, you took out #{@score[:enemies_destroyed]} enemy ships."
    end

    def message_count_reached
      @message = "You made it! You destroyed #{@score[:enemies_destroyed]} ships"
      @message2 = "and #{@score[:enemies_escaped]} reached the base."
    end

    def message_hit_top
      @message = "You got too close to the enemy mother ship."
      @message2 = "Before your ship was destroyed, you took out #{@score[:enemies_destroyed]} enemy ships."
    end
  end
end
