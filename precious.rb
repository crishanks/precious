require_relative 'parser.rb'
# eventually we could take in user input so they can name their .precious files whatever they want
file = "middle_earth.precious"

def check_extension(file)
  accepted_formats = '.precious'
  ext = File.extname(file)
  if accepted_formats == ext
    open_file(file)
  else
    raise 'This is not a *Gollum  Cough* *Gollum Cough* precious (file)!'
    
  end
end

def open_file(filename)
  File.open(filename) do |file|
    file.each_line do |line|
      # puts line

      Parser.parse_line(line)
    end
  end
end


check_extension(file)