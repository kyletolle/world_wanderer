require 'io/console'

class Wanderer
  attr_reader :x, :y

  def initialize
    @x = 0
    @y = 0
  end

  def set_location(x,y)
    @x = x
    @y = y
  end

  def at_location?(x, y)
    x == @x && y == @y
  end
end

class World
  DIMENSION = 10

  def initialize(wanderer)
    @wanderer = wanderer
  end

  def map
    text_representation = ""
    DIMENSION.times.each do |x|
      DIMENSION.times.each do |y|
        wanderer_present = @wanderer.at_location?(x, y)

        if wanderer_present
          if y == DIMENSION-1
            text_representation << " W  "
          else
            text_representation << " W |"
          end

        else
          if y == DIMENSION-1
            text_representation << "   "
          else
            text_representation << "   |"
          end
        end
      end

      text_representation << "\n"

      unless x+1 == DIMENSION
        text_representation << "-"*39
        text_representation << "\n"
      end
    end
    text_representation
  end
end

wanderer = Wanderer.new

world = World.new(wanderer)

loop do
  puts world.map

  character_typed = STDIN.getch

  case character_typed
  when 'w','W'
    if wanderer.x == 0
      wanderer.set_location(World::DIMENSION-1, wanderer.y)
    else
      wanderer.set_location(wanderer.x-1, wanderer.y)
    end

  when 'a','A'
    if wanderer.y == 0
      wanderer.set_location(wanderer.x, World::DIMENSION-1)
    else
      wanderer.set_location(wanderer.x, wanderer.y-1)
    end

  when 's','S'
    if wanderer.x == World::DIMENSION-1
      wanderer.set_location(0, wanderer.y)
    else
      wanderer.set_location(wanderer.x+1, wanderer.y)
    end

  when 'd','D'
    if wanderer.y == World::DIMENSION-1
      wanderer.set_location(wanderer.x, 0)
    else
      wanderer.set_location(wanderer.x, wanderer.y+1)
    end

  when 'q','Q'
    exit
  end

  puts "\n"*30
end
