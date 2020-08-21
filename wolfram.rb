class Wolfram
    attr_accessor :tape

    def initialize(tape, rule = 30)
        @tape = tape
        @rules = rule.to_s(2).rjust(8, "0").reverse
    end

    def pattern(index)
        left = index != 0 ? @tape[index - 1] : @tape[-1, 1]
        right = index != @tape.length - 1 ? @tape[index + 1] : @tape[0, 1]
        return left + @tape[index] + right
    end

    def next
        new_tape = @tape.dup
        @tape.chars.each_with_index do |state, index|
            new_state = @rules[pattern(index).to_i(2)]
            new_tape[index] = new_state
        end
        @tape = new_tape
    end
end

if ARGV.length == 3
    tape, rule, iterations = ARGV[0], ARGV[1].to_i, ARGV[2].to_i
    ca = Wolfram.new(tape, rule)
    (0...iterations).each do |iteration|
        # Show current iteration
        print "gen=" + iteration.to_s.rjust(iterations.to_s.length, "0") + " "
        # Show the tape 
        print ca.tape.gsub("0", "░").gsub("1", "█") + " "
        # Show the count of state(1) cells
        print "n=" + ca.tape.count("1").to_s + "\n"
        # Generate next generation
        ca.next
    end
end