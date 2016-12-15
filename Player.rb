class Player
  attr_reader :score
  attr_accessor :lives

  def initialize
    @image = Gosu::Image.new("pictures/arnold.png")
    @beep = Gosu::Sample.new("pictures/mburger.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @lives = 100
    #@donutsound = Gosu::Sample.new("pictures/laugh.wav")
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 2000
    @y %= 2424

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def score
    @score
  end

  def lives
    @lives
  end

  def x
    return @x
  end

  def y
    return @y
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 60 then
        @score += 10
        @beep.play
        true
      else
        false
      end
    end
  end

  def collect_powerup(powerup)

    powerup.reject! do |powerup|
      if Gosu::distance(@x, @y, powerup.x, powerup.y) < 60 then
        @lives += 10
        true
      #  @donutsound.play
      else
        false
      end
    end

  end
end
