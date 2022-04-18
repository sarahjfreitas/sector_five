module Scene
  class End
    def initialize(window,mode,score)
      @window = window
      @mode = mode
      @score = score
    end

    def button_down(id)
      @window.change_scene(:start)
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
