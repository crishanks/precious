require 'pry'

class Parser
  WRITER_FILE = 'output.rb'
  # KEYWORDS
  PUT_KEYWORDS = ['bring forth the ring', 'gandalf says']
  COMMENT_KEYWORD = 'second breakfast'
  FILLER_KEYWORDS = ['is', 'has', 'was']
  ASSIGNMENT_KEYWORD = '.'
  COMPARISON_KEYWORD = '?'
  INCREMENT_KEYWORD = 'eats lembas bread'
  DECREMENT_KEYWORD = 'runs out of lembas bread'
  ADDITION_KEYWORD = 'join the fellowship'
  SUBTRACTION_KEYWORD = 'leave the fellowship'
  DIVISION_KEYWORD = 'decapitates'
  MULTIPLICATION_KEYWORD = 'gives aid to'

  ALL_KEYS = [PUT_KEYWORDS, COMMENT_KEYWORD, FILLER_KEYWORDS, ASSIGNMENT_KEYWORD,
    COMPARISON_KEYWORD, INCREMENT_KEYWORD, DECREMENT_KEYWORD, ADDITION_KEYWORD,
  SUBTRACTION_KEYWORD, DIVISION_KEYWORD, MULTIPLICATION_KEYWORD]

  def self.parse_file(file)
    file.each_with_index do |file, index|
      file.each_line do |line|
        Parser.parse_line(line, index)
      end
    end
  end

  def self.parse_line(line, index)
    line = line.downcase
    #error handeling
    #ignore lines of length 1, its empty
    if (line.length != 1 && (ALL_KEYS.flatten.any? { |keys| line.include?(keys)}))

      while (ALL_KEYS.flatten.any? { |keys| line.include?(keys) })
        puts "in loop"
        puts line
        if PUT_KEYWORDS.any? { |word| line.include?(word) }
          line = parse_put(line)
        elsif line.include?(COMMENT_KEYWORD)
          line = parse_comment(line)
        elsif FILLER_KEYWORDS.any? { |word| line.split(" ").include?(word) } #assignment/comparison
          binding.pry
          if line.include?(ASSIGNMENT_KEYWORD)
            line = parse_assignment(line)
          else #compairson
            line = parse_comparison(line)
          end
        elsif line.include?(INCREMENT_KEYWORD)
          line = parse_increment(line)
        elsif line.include?(DECREMENT_KEYWORD)
          line = parse_decrement(line)
        elsif line.include?(ADDITION_KEYWORD)
          line = parse_addition(line)
        elsif line.include?(SUBTRACTION_KEYWORD)
          line = parse_subtraction(line)
        elsif line.include?(DIVISION_KEYWORD)
          line = parse_division(line)
        elsif line.include?(MULTIPLICATION_KEYWORD)
          line = parse_multiplication(line)
        else
          puts line
          write(line)
        end
      end
    else
      abort "line #{index} has syntax error: #{line}"
      exit
    end

  end

  # METHODS
  def self.parse_put(line)
    PUT_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, 'puts')
      end
    end
    return line
    write(line)
  end

  def self.parse_comment(line)
    comment_string = line.gsub(COMMENT_KEYWORD, '#')
    return comment_string
    write(comment_string)
  end

  def self.parse_assignment(line)
    line_array = line.split(' ')
    line_array.each_with_index do |word, index|
      if FILLER_KEYWORDS.include?(word)
        line_array[index] = '='
      end
    end
    new_line_string = line_array.join(' ')
    final_line = new_line_string.gsub('.', '')
    return final_line
    write(final_line)
  end

  def self.parse_comparison(line)
    line_array = line.split(' ')
    var1 = line_array[1]
    var2 = line_array[2].gsub('?', "")
    string = "#{var1} == #{var2}"
    return string
    write(string)
  end

  def self.parse_increment(line)
    line_array = line.split(' ')
    first_word = line_array[0]
    rest_of_line = ' += 1'
    phrase = first_word + rest_of_line
    return phrase
    write(phrase)
  end

  def self.parse_decrement(line)
    line_array = line.split(' ')
    first_word = line_array[0]
    rest_of_line = ' -= 1'
    phrase = first_word + rest_of_line
    return phrase
    write(phrase)
  end

  def self.parse_addition(line)
    line = line.gsub('and', '+')
    line_array = line.split('join the fellowship')
    return line_array[0]
    write(line_array[0])
  end

  def self.parse_subtraction(line)
    line = line.gsub('and', '-')
    line_array = line.split('leave the fellowship')
    return line_array[0]
    write(line_array[0])
  end

  def self.parse_division(line)
    line = line.gsub('decapitates', '/')
    return line
    write(line)
  end

  def self.parse_multiplication(line)
    line = line.gsub('gives aid to', '*')
    return line
    write(line)
  end

  def self.write(str)
    if File.exist?(WRITER_FILE)
      writer_file = File.open(WRITER_FILE, 'a')
    else
      writer_file = File.open(WRITER_FILE, 'w')
    end
    writer_file.write(str + "\n")
  end

end

# Future Functionalilty
# 1. For doing multiple operations on a line
# Changed Version of parse_line method
# - While loop - while there are keywords in the line
#  - create a variable that would store the updated string
#  - do if statements (ex: if line.include?(is)...)
#  - call the corresponding parse_ methods. Instead of writing in those, we would return a value
# - after the loop we write the string to the output.rb file
