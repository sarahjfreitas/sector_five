class Player
  ROTATION_SPEED = 3
  ACELERATION = 4
  FRICTION = 0.9
  RADIUS = 20

  def initialize(window)
    @x = 200
    @y = 200
    @angle = 0
    @image = Gosu::Image.new('images/ship.png')
    @velocity_x = 0
    @velocity_y = 0
    @window = window
  end

  def draw
    @image.draw_rot(@x,@y,1,@angle)
  end

  def turn_right
    @angle += ROTATION_SPEED
  end

  def turn_left
    @angle -= ROTATION_SPEED
  end

  def acelerate
    @velocity_x += Gosu::offset_x(@angle,ACELERATION) * 0.1
    @velocity_y += Gosu::offset_y(@angle,ACELERATION) * 0.1
  end

  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= FRICTION
    @velocity_y *= FRICTION

    if hit_right_border? or hit_left_border?
      @velocity_x *= -1
      @angle *= -1
      @x = (@x - 2 * RADIUS).abs
    elsif hit_bottom_border?
      @velocity_y *= -1
      @angle -= 180
      @y = @window.height - RADIUS
    elsif hit_top?
      @velocity_y *= -1
      @angle += 180
      @y = RADIUS
    end
  end

  def fire
    Bullet.new @window,@x,@y,@angle
  end

  private

  def hit_left_border?
    @x < RADIUS
  end

  def hit_right_border?
    @x > @window.width - RADIUS
  end

  def hit_bottom_border?
    @y > @window.height - RADIUS
  end

  def hit_top?
    @y < RADIUS
  end
end
