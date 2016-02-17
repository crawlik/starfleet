class Ship

  MOVE_CMDS = [:north, :south,:east, :west]
  FIRE_CMDS = [:alpha, :beta, :gamma, :delta]
  NOOP_CMD = :noop

  def initialize(field)
    @field = field
    # position in the center of the field
    @z = 0
    max_x, max_y = *@field.cross_section
    @x = max_x/2
    @y = max_y/2
    @move_commands = 0
    @fire_commands = 0
  end

  attr_reader :x
  attr_reader :y
  attr_reader :z
  attr_reader :fire_commands
  attr_reader :move_commands

  def fire(type)
    mines = []
    case type
    when :alpha
      mines += @field.xy_mines(x+1,y+1) +
        @field.xy_mines(x+1,y-1) +
        @field.xy_mines(x-1,y+1) +
        @field.xy_mines(x-1,y-1)
    when :beta
      mines += @field.xy_mines(x,y-1) +
        @field.xy_mines(x,y+1) +
        @field.xy_mines(x+1,y) +
        @field.xy_mines(x-1,y)
    when :gamma
      mines += @field.xy_mines(x+1,y) +
        @field.xy_mines(x-1,y) +
        @field.xy_mines(x,y)
    when :delta
      mines +=  @field.xy_mines(x,y-1) +
        @field.xy_mines(x,y+1) +
        @field.xy_mines(x,y)
    end
    @field.destroy_mines(mines)
    @fire_commands += 1
  end

  def move(direction)
    case direction
    when :north
      @y -= 1
    when :south
      @y += 1
    when :east
      @x += 1
    when :west
      @x -= 1
    end
    @move_commands += 1
  end

  def execute(commands)
    commands.each do |command|
      if MOVE_CMDS.include?(command)
        move(command)
      elsif FIRE_CMDS.include?(command)
        fire(command)
      else
        raise "Unsupported command #{command}"
      end
    end
    drop
  end

  def drop
    @z -= 1
  end

end
