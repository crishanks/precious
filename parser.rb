require 'pry'

class Parser
  WRITER_FILE = 'output.rb'
  # KEYWORDS
  PUT_KEYWORDS = ['bring forth the ring', 'says']
  COMMENT_KEYWORDS = ['second breakfast']
  ASSIGNMENT_KEYWORDS = ['is', 'has', 'was']
  INCREMENT_KEYWORDS = ['eats lembas bread']
  DECREMENT_KEYWORDS = ['runs out of lembas bread']
  ADDITION_KEYWORDS = ['joins the fellowship', 'and']
  SUBTRACTION_KEYWORDS = ['leaves the fellowship']
  DIVISION_KEYWORDS = ['decapitates']
  MULTIPLICATION_KEYWORDS = ['gives aid to']
  OPERATOR_KEYWORDS = ['+', '-', '=', '*', '/', '+=', '-=', 'puts']

  ALL_KEYS = [PUT_KEYWORDS, COMMENT_KEYWORDS, ASSIGNMENT_KEYWORDS,
     INCREMENT_KEYWORDS, DECREMENT_KEYWORDS, ADDITION_KEYWORDS,
  SUBTRACTION_KEYWORDS, DIVISION_KEYWORDS, MULTIPLICATION_KEYWORDS]

  def self.parse_file(file)
    file.each_with_index do |file, index|
      file.each_line do |line|
        Parser.parse_line(line, index)
      end
    end
  end

  def self.parse_line(line, index)

    #check if there are strings in line
    quote = ""
    if line.include? '"'
      quote = check_for_string(line)
      line = line.gsub(quote, 'quote_placeholder')
    end

    #get rid of special chars
    line_array = line.split(" ")
    line_array.each_with_index do |word, index|
      line_array[index] = purify(word)
    end

    #check for keywords
    line = line_array.join(" ")
    line = check_for_keywords(line)

    #remove extra english words
    line = only_valuable_words(line)

    #put string back into line
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
      if COMMENT_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_comment(line)
      end
      if ASSIGNMENT_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_assignment(line)
      end
      if INCREMENT_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_increment(line)
      end
      if DECREMENT_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_decrement(line)
      end
      if ADDITION_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_addition(line)
      end
      if SUBTRACTION_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_subtraction(line)
      end
      if DIVISION_KEYWORDS.any? { |word| line.include?(word) }
        line = parse_division(line)
      end
      if MULTIPLICATION_KEYWORDS.any? { |word| line.include?(word) }
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
    COMMENT_KEYWORD.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, '#')
      end
    end
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

  # def self.parse_comparison(line)
  #   PUT_KEYWORDS.each do |keyword|
  #     if line.include? keyword
  #       line = line.gsub(keyword, '==')
  #     end
  #   end
  #   return string
  #   write(string)
  # end

  def self.parse_increment(line)
    INCREMENT_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, '+=')
      end
    end
    return line
    write(line)
  end

  def self.parse_decrement(line)
    DECREMENT_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, '-=')
      end
    end
    return line
    write(line)
  end

  def self.parse_addition(line)
    ADDITION_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, '+')
      end
    end
    return line
    write(line)
  end

  def self.parse_subtraction(line)
    SUBTRACTION_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, '-')
      end
    end
    return line
    write(line)
  end

  def self.parse_division(line)
    DIVISION_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, '/')
      end
    end
    return line
    write(line)
  end

  def self.parse_multiplication(line)
    MULTIPLICATION_KEYWORDS.each do |keyword|
      if line.include? keyword
        line = line.gsub(keyword, '*')
      end
    end
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

  def self.only_valuable_words(line)
    important_words = []
    line_array = line.split(" ")
    line_array.each do |word|
      valuable_word = valuable?(word)
      if valuable_word
        important_words << word
      end
    end
    line = important_words.join(" ")
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
