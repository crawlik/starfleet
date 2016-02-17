#!/usr/bin/env ruby

require_relative 'field'
require_relative 'script'
require_relative 'ship'

class Grader

  def initialize(field, script)
    @field = Field.new
    @field.parse(field)
    @script = Script.new
    @script.parse(script)
    @ship = Ship.new(@field)
    @step = 1
  end

  def run
    loop do
      puts "Step #{@step}\n\n"
      print_map
      puts "\n"
      commands = @script.steps[@step-1].flatten
      puts format_commands(commands)
      @ship.execute(commands)
      puts "\n"
      print_map
      puts "\n"
      @step += 1
      break if @step > @script.steps.size || @field.mine_count == 0 || @field.missed_mine?(@ship.z)
    end
    puts summary
  end

  protected

  def print_map
    size_x = size_y = 0
    @field.mines_x.each_with_index do |x, i|
      size_x = (x - @ship.x).abs if x.abs > size_x
      size_y = (@field.mines_y[i] - @ship.y).abs if @field.mines_y[i].abs > size_y
    end
    map = Array.new(2*size_y + 1) { Array.new(2*size_x + 1, '.') }
    @field.mines_x.each_with_index do |x, i|
      mine_distance = @ship.z - @field.mines_z[i]
      map[@field.mines_y[i] - (@ship.y - size_y)][x - (@ship.x - size_x)] =
        case mine_distance
        when 1..26
          (mine_distance+96).chr
        when 27..52
          (mine_distance+38).chr
        else '*'
        end
    end
    map.each { |i| puts i.join }
  end

  def format_commands(commands)
    commands.join(' ')
  end

  def summary
    if @field.missed_mine?(@ship.z) ||
       (@field.mine_count > 0 && @step == @script.steps.size + 1)
      return 'fail (0)'
    elsif @field.mine_count == 0 && @step == @script.steps.size
      return 'pass (1)'
    else
      score = @field.deployed_mines * 10
      score = score - [5 * @field.deployed_mines, 5 * @ship.fire_commands].min
      score = score - [2 * @ship.move_commands, 3 * @field.deployed_mines].min
      return "pass (#{score})"
    end
  end
end