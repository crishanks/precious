require 'pry'

class Parser
  WRITER_FILE = 'output.rb'
  # KEYWORDS
  PUT_KEYWORDS = ['bring forth the ring', 'says']
  COMMENT_KEYWORD = 'second breakfast'
  ASSIGNMENT_KEYWORDS = ['is', 'has', 'was']
  #COMPARISON_KEYWORD = 'if'
  INCREMENT_KEYWORD = 'eats lembas bread'
  DECREMENT_KEYWORD = 'runs out of lembas bread'
  ADDITION_KEYWORD = 'joins the fellowship'
  SUBTRACTION_KEYWORD = 'leaves the fellowship'
  DIVISION_KEYWORD = 'decapitates'
  MULTIPLICATION_KEYWORD = 'gives aid to'
  OPERATOR_KEYWORDS = ['+', '-', '=', '*', '/', '+=', '-=', 'puts']

  ALL_KEYS = [PUT_KEYWORDS, COMMENT_KEYWORD, ASSIGNMENT_KEYWORDS,
     INCREMENT_KEYWORD, DECREMENT_KEYWORD, ADDITION_KEYWORD,
  SUBTRACTION_KEYWORD, DIVISION_KEYWORD, MULTIPLICATION_KEYWORD]

  def self.parse_file(file)
    file.each_with_index do |file, index|
      file.each_line do |line|
        Parser.parse_line(line, index)
      end
    end
  end

  def self.parse_line(line, index)
    quote = ""
    if line.include? '"'
      quote = check_for_string(line)
      line = line.gsub(quote, 'quote_placeholder')
    end

    line_array = line.split(" ")
    line_array.each_with_index do |word, index|
      line_array[index] = purify(word)
    end

    line = line_array.join(" ")
    line = check_for_keywords(line)

    important_words = []
    line_array = line.split(" ")
    line_array.each do |word|
      valuable_word = valuable?(word)
      if valuable_word
        important_words << word
      end
    end
    line = important_words.join(" ")

    if line.include? ('"quote_placeholder"')
      line = line.gsub('quote_placeholder', quote)
    end
    puts "end line: #{line}"

  end

  def self.check_for_keywords(line)
    #error handeling
    #ignore lines of length 1, its empty
    if line.length == 1
      write("\n")
    else
      if PUT_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_put(line)
      end
      if line.include?(COMMENT_KEYWORD)
        line = parse_comment(line)
      end
      if ASSIGNMENT_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_assignment(line)
      end
      # elsif line.include?(COMPARISON_KEYWORD)
      #   line = parse_comparison(line)
      if line.include?(INCREMENT_KEYWORD)
        line = parse_increment(line)
      end
      if line.include?(DECREMENT_KEYWORD)
        line = parse_decrement(line)
      end
      if line.include?(ADDITION_KEYWORD)
        line = parse_addition(line)
      end
      if line.include?(SUBTRACTION_KEYWORD)
        line = parse_subtraction(line)
      end
      if line.include?(DIVISION_KEYWORD)
        line = parse_division(line)
      end
      if line.include?(MULTIPLICATION_KEYWORD)
        line = parse_multiplication(line)
      end
    end
    line
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
    ASSIGNMENT_KEYWORDS.each do |key|
      line = line.gsub(key, "=")
    end
    return line
    write(line)
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
    line = line.gsub(ADDITION_KEYWORD, '+')
    return line
    write(line)
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

  def self.purify(word)
    word = word.gsub(/[!@%&.]/,'') # get rid of special chars
  end

  def self.valuable?(word)
    valuable = false
    if /[[:upper:]]/.match(word[0]) #if variable
      valuable = true
    elsif word == '"quote_placeholder"' #if string
      valuable = true
    elsif word.to_i.to_s == word #if num
      valuable = true
    elsif OPERATOR_KEYWORDS.include? word #if operator
      valuable = true
    end
    valuable
  end

  def self.check_for_string(phrase)
    phrase_array = phrase.split('')
    index = phrase_array.find_index { |i| i == '"'} + 1
    quote = ""
    while phrase_array[index] != '"'
      quote << phrase_array[index]
      index += 1
    end
    quote
  end


end
