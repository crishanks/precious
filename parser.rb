class Parser
  PUT = 'bring forth the ring'

  def self.parse_line(line)

    line_array = line.split(' ')
    if line.include?(PUT)
      parse_put(line)
    end
    # line_array.each do |word|
    #   pattern = 
    # end
  end

  def self.parse_put(line)
    line_array = line.split('bring forth the ring')
    puts line_array
  end
end