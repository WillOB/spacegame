class Enemy

  def initialize
  @image = Gosu::Image.new("pictures/bigpadjen.png")
  @x = @y = @vel_x = @vel_y = @angle = 0.0

#  @noise1 = Gosu::Sample.new("pictures/crap.wav")
#  @noise2 = Gosu::Sample.new("pictures/scream.wav")
#  @noise3 = Gosu::Sample.new("pictures/tohellwiththis.wav")
#  @noise = Gosu::Sample.new("pictures/doh.wav")
  end


  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 2000
    @y %= 2424

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def angle
    @angle = 90
  end

#  def playsound
#    if Gosu::distance(@x, @y, player.x, player.y) < 60 then
#    num = rand(4)
#    if num == 1
#      @noise1.play
#    elsif num == 2
#      @noise2.play
#    elsif num == 3
#      @noise3.play
#    else
#      @noise.play
#    end
#    end
#  end



  def attack(player)

    if Gosu::distance(@x, @y, player.x, player.y) < 100
       #@noise.play

       player.lives -= 1
    end
  end
end
