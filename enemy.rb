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
    if targets.is_a? Array
      targets.each do |target|
        return target if target_collided?(target)
      end
    else
      return targets if target_collided?(targets)
    end

    nil
  end

  private

  def image
    @_image ||= Gosu::Image.new('images/enemy.png')
  end

  def target_collided?(target)
    distance = Gosu::distance(@x, @y, target.x, target.y)
    distance <= RADIUS + target.radius
  end
end
