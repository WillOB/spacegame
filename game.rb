require "gosu"
require "./player"
require "./star"
require "./enemy"
require "./powerup"

class GameWindow < Gosu::Window

  def initialize
    super 2000, 2424
    self.caption  = "monster"

     @background_image = Gosu::Image.new("pictures/funpolice.png", :tileable => true)

     @player = Player.new
     @player.warp(1000, 1212)

     @star_anim = Gosu::Image::load_tiles("pictures/burger.png", 128, 128)
     @stars = Array.new
     @font = Gosu::Font.new(40)
     @powerups = Array.new
     @powerup_anim = Gosu::Image::load_tiles("pictures/donut2.png", 128, 128)
     @enemy = Enemy.new
     @enemy2 = Enemy.new
     @enemy3 = Enemy.new
     @enemy4 = Enemy.new
     @enemy.warp(rand(2000), rand(2424))
     @enemy2.warp(rand(2000), rand(2424))
     @enemy3.warp(rand(2000), rand(2424))
     @enemy4.warp(rand(2000), rand(2424))
   end

  def update

    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
     @player.turn_left
   end
   if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
     @player.turn_right
   end
   if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
     @player.accelerate
   end
    @player.move
    @player.collect_stars(@stars)
    @player.collect_powerup(@powerups)

    @enemy2.angle
    @enemy4.angle
    @enemy.move
    @enemy2.move
    @enemy3.move
    @enemy4.move
    @enemy.accelerate
    @enemy2.accelerate
    @enemy3.accelerate
    @enemy4.accelerate
    @enemy.attack(@player)
    @enemy2.attack(@player)
    @enemy3.attack(@player)
    @enemy4.attack(@player)


    if rand(100) < 4 and @stars.size < 20 then
      @stars.push(Star.new(@star_anim))
    end

    if rand(100) < 2 and @powerups.size < 5 then
      @powerups.push(Powerup.new(@powerup_anim))
    end
  end

  def draw
   @background_image.draw(0, 0, ZOrder::Background)
   @player.draw
   @stars.each { |star| star.draw }
   @font.draw("Score: #{@player.score}", 10, 10 , ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
   @font.draw("Lives: #{@player.lives}", 10, 70 , ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
   @enemy.draw
   @enemy2.draw
   @enemy3.draw
   @enemy4.draw
   @powerups.each { |powerup| powerup.draw }
   if @player.lives <= 0
     @font.draw("Game Over!", 500, 1400, ZOrder::UI, 4.0, 4.0, 0xff_000000)
     @font.draw("You had #{@player.score} points.", 400, 1600, ZOrder::UI, 4.0, 4.0, 0xff_000000)
   end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end


module ZOrder
  Background, Stars, Player, UI = *0..3
end


window = GameWindow.new
window.show
