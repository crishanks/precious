require 'pry'

class Parser
  WRITER_FILE = 'output.rb'
  # KEYWORDS
  #PUT_KEYWORD = 'bring forth the ring'
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

  def self.parse_line(line)
    line = line.downcase
    # if line.include?(PUT_KEYWORDS)
    #   parse_put(line)
    if PUT_KEYWORDS.any? { |word| line.include?(word) }
      parse_put(line)
    elsif line.include?(COMMENT_KEYWORD)
      parse_comment(line)
    elsif FILLER_KEYWORDS.any? { |word| line.include?(word) }
    #elsif line.include?('.') #ASSIGNMENT_KEYWORD
      parse_assignment(line)
    elsif line.include?(INCREMENT_KEYWORD)
      parse_increment(line)
    elsif line.include?(DECREMENT_KEYWORD)
      parse_decrement(line)
    elsif line.include?(ADDITION_KEYWORD)
      parse_addition(line)
    elsif line.include?(SUBTRACTION_KEYWORD)
      parse_subtraction(line)
    elsif line.include?(DIVISION_KEYWORD)
      parse_division(line)
    elsif line.include?(MULTIPLICATION_KEYWORD)
      parse_multiplication(line)

    #else
    # error handling?
    end

  end

  # METHODS
  def self.parse_put(line)
    # puts_string = line.gsub(PUT_KEYWORD, 'puts')
    # write(puts_string)
    PUT_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, 'puts')
      end
    end
    write(line)
  end

  def self.parse_comment(line)
    comment_string = line.gsub(COMMENT_KEYWORD, '#')
    write(comment_string)
  end

  # Our parse_comment method is messing up the output.rb when we run the precious.rb file.
  # Puts and comments give an extra new line.
  def self.parse_assignment(line)
    line_array = line.split(' ')
    line_array.each_with_index do |word, index|
      if FILLER_KEYWORDS.include?(word)
        line_array[index] = '='
      end
    end
    new_line_string = line_array.join(' ')
    final_line = new_line_string.gsub('.', '')
    write(final_line)
  end

  def self.parse_increment(line)
    line_array = line.split(' ')
    first_word = line_array[0]
    rest_of_line = ' += 1'
    phrase = first_word + rest_of_line
    write(phrase)
  end

  def self.parse_decrement(line)
    line_array = line.split(' ')
    first_word = line_array[0]
    rest_of_line = ' -= 1'
    phrase = first_word + rest_of_line
    write(phrase)
  end

  def self.parse_addition(line)
    line = line.gsub('and', '+')
    line_array = line.split('join the fellowship')
    write(line_array[0])
  end

  def self.parse_subtraction(line)
    line = line.gsub('and', '-')
    line_array = line.split('leave the fellowship')
    write(line_array[0])
  end

  def self.parse_division(line)
    line = line.gsub('decapitates', '/')
    write(line)
  end

  def self.parse_multiplication(line)
    line = line.gsub('gives aid to', '*')
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
