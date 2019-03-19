require_relative 'parser.rb'

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

def open_file(filename)
  file = File.open(filename)
  Parser.parse_file(file)
end

def destroy_output_file(writer_file)
  if File.exist?(writer_file)
    File.delete(writer_file)
  end
end

check_extension(reader_file, writer_file)
