class Explosion
  RADIUS = 30

  def initialize(window,x,y)
    @window = window
    @x = x
    @y = y
    @image_index = 0
  end

  def draw
    images[@image_index].draw_rot(@x,@y,2) if not finished?
    @image_index+=1
  end

  def finished?
    @image_index >= images.count
  end

  private

  def images
    @_images ||= Gosu::Image.load_tiles('images/explosions.png',60,60)
  end
end
