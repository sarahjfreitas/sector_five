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

  def got_hit_by(bullets)
    bullets.each do |bullet|
      distance = Gosu::distance(@x, @y, bullet.x, bullet.y)
      return bullet if distance <= RADIUS + bullet.radius
    end

    nil
  end

  private

  def image
    @_image ||= Gosu::Image.new('images/enemy.png')
  end
end
