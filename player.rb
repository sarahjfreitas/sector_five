class Player
  ROTATION_SPEED = 3
  ACELERATION = 2
  FRICTION = 0.9

  def initialize(window)
    @x = 200
    @y = 200
    @angle = 0
    @image = Gosu::Image.new('images/ship.png')
    @velocity_x = 0
    @velocity_y = 0
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
    @velocity_x * FRICTION
    @velocity_y * FRICTION
  end
end
