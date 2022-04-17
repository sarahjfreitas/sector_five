class Enemy
  RADIUS = 20
  SPEED = 4
  attr_reader :x,:y

  def initialize(window)
    @x = rand(window.width - 2 * RADIUS) + RADIUS
    @y = 0
    @window = window
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

  def off_screen?
    @y > @window.height + RADIUS
  end

  def got_hit_by(targets)
    targets.each do |target|
      distance = Gosu::distance(@x, @y, target.x, target.y)
      return target if distance <= RADIUS + target.radius
    end

    nil
  end

  private

  def image
    @_image ||= Gosu::Image.new('images/enemy.png')
  end
end
