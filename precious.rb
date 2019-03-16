require_relative 'parser.rb'
# eventually we could take in user input so they can name their .precious files whatever they want
reader_file = "middle_earth.precious"

def check_extension(reader_file)
  accepted_formats = '.precious'
  ext = File.extname(reader_file)
  if accepted_formats == ext
    destroy_output_file
    open_file(reader_file)
  else
    raise 'This is not a *Gollum  Cough* *Gollum Cough* precious (file)!'
    
  end
end

def open_file(filename)
  File.open(filename) do |file|
    file.each_line do |line|
      Parser.parse_line(line)
    end
  end
end

def destroy_output_file
  if File.exist?('output.rb')
    File.delete('output.rb')
  end
end


check_extension(reader_file)