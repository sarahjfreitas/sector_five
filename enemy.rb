class Enemy
  RADIUS = 20
  SPEED = 4
  attr_reader :x,:y

  def initialize(window)
    @x = rand(window.width - 2 * RADIUS) + RADIUS
    @y = 0
  end

  def draw
    image.draw_rot(@x,@y,1)
  end

  def move
    @y += SPEED
  end

  def radius
    RADIUS
  end

  private

  def image
    @_image ||= Gosu::Image.new('images/enemy.png')
  end
end
