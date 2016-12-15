class Powerup

  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @x = rand * 2000
    @y = rand * 2424
    @color = Gosu::Color.new(0xff_ff69b4)
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        ZOrder::Stars, 1, 1, @color, :add)
  end
end
