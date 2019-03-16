class Parser
  PUT = 'bring forth the ring'
  #COMMENT = 'second breakfast'

  def self.parse_line(line)
    line_array = line.split(' ')
    if line.include?(PUT)
      parse_put(line)
    # elsif
      #line.include?(COMMENT)
    end

  end

  def self.parse_put(line)
    line_array = line.split('bring forth the ring')
    File.write('output.rb', 'puts' + line_array[1])
  end

  # def self.parse_comment(line)
  # end

end