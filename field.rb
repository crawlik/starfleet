class Field
  def initialize()
    @mine_count = @deployed_mines = 0
    @max_x = 0
    @max_y = 0
    @mines_x = []
    @mines_y = []
    @mines_z = []
  end

  attr_reader :mine_count
  attr_reader :deployed_mines
  attr_reader :mines_x
  attr_reader :mines_y
  attr_reader :mines_z

  def cross_section
    return @max_x, @max_y
  end

  def parse(lines)
    @max_x = lines.first.size
    @max_y = lines.size
    lines.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        case char
        when '.'
        when /[a-z]/
          add_mine(x, y, -(char.ord-96))
        when /[A-Z]/
          add_mine(x, y, -(char.ord-38))
        else raise "Unknown character"
        end
      end
    end
  end

  def add_mine(x, y, z)
    @mines_x << x
    @mines_y << y
    @mines_z << z
    @deployed_mines = (@mine_count += 1)
  end

  def xy_mines(x, y)
    result = []
    mines_x.each_with_index do |mine_x, i|
      result << i if mine_x == x && mines_y[i] == y
    end
    result
  end

  def destroy_mines(mines)
    mines.each do |i|
      @mines_x.delete_at(i)
      @mines_y.delete_at(i)
      @mines_z.delete_at(i)
      @mine_count -= 1
    end
  end

  def missed_mine?(ship_z)
    @mines_z.any? {|i| i >= ship_z}
  end
end
