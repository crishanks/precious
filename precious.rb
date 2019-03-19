require_relative 'parser.rb'
#Ask user for input file name
#Ask user for output file name
reader_file = "middle_earth.precious"
writer_file = "output.rb"

def check_extension(reader_file, writer_file)
  accepted_formats = '.precious'
  ext = File.extname(reader_file)
  if accepted_formats == ext
    destroy_output_file(writer_file)
    open_file(reader_file)
  else
    raise 'This is not a *Gollum  Cough* *Gollum Cough* precious (file)!'

  end
end

#this should be a method called parse_file in Parser class
#keep ALL parsing in Parse, separation of responsibilities
#we would call it by Parser.parse_file(filename)
def open_file(filename)
  File.open(filename) do |file|
    file.each_line do |line|
      Parser.parse_line(line)
    end
  end
end

def destroy_output_file(writer_file)
  if File.exist?(writer_file)
    File.delete(writer_file)
  end
end

check_extension(reader_file, writer_file)
