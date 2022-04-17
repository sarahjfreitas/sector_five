class Bullet
  RADIUS = 3
  SPEED = 5
  attr_reader :x,:y

  def initialize(window,x,y,angle)
    @window = window
    @x = x
    @y = y
    @angle = angle
  end

  def draw
    image.draw_rot(@x,@y,1)
  end

  def move
    @x += Gosu::offset_x(@angle, SPEED)
    @y += Gosu::offset_y(@angle, SPEED)
  end

  def radius
    RADIUS
  end

  private

  def image
    @_image ||= Gosu::Image.new('images/bullet.png')
  end
end
