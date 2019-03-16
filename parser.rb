class Parser
  PUT_KEYWORD = 'bring forth the ring'
  COMMENT_KEYWORD = 'second breakfast'
  WRITER_FILE = 'output.rb'

  def self.parse_line(line)
    # line_array = line.split(' ')
    if line.include?(PUT_KEYWORD)
      parse_put(line)
    elsif line.include?(COMMENT_KEYWORD)
      parse_comment(line)
    end

  end

  def self.parse_put(line)
    puts_string = line.gsub(PUT_KEYWORD, 'puts')
    write(puts_string)
  end

  def self.parse_comment(line)
    comment_string = line.gsub(COMMENT_KEYWORD, '#')
    write(comment_string)
  end

  def self.write(str)
    if File.exist?(WRITER_FILE)
      writer_file = File.open(WRITER_FILE, 'a')
    else
      writer_file = File.open(WRITER_FILE, 'w')
    end
    writer_file.write(str)
  end

end