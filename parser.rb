class Parser
  PUT_KEYWORD = 'bring forth the ring'
  #COMMENT = 'second breakfast'

  def self.parse_line(line)
    # line_array = line.split(' ')
    if line.include?(PUT_KEYWORD)
      parse_put(line)
    # elsif
      #line.include?(COMMENT)
    end

  end

  def self.parse_put(line)
    puts_string = line.gsub(PUT_KEYWORD, 'puts')
    write(puts_string)
  end

  # def self.parse_comment(line)
  # end

  def self.write(str)
    File.write('output.rb', str)
  end

end