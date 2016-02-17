class Script

  attr_reader :steps

  def initialize()
    @steps = []
  end

  def parse(lines)
    lines.each do |line|
      commands = []
      case line
      when ' '
        commands << :noop
      else
        commands << line.split(' ').map(&:to_sym)
      end
      @steps << commands
    end
  end
end
