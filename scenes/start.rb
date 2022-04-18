module Scene
  class Start
    def initialize(window)
      @window = window
      @start_music = Gosu::Song.new('sounds/Lost Frontier.ogg')
      @start_music.play(true)
    end

    def button_down(id)
      @window.change_scene(:game)
    end

    def update
    end

    def draw
      background_image.draw(0,0,0)
    end

    private

    def background_image
      @_background_image ||= Gosu::Image.new('images/start_screen.png')
    end
  end
end
