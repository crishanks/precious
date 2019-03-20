require_relative 'parser.rb'

reader_file = "shire.precious"
writer_file = "output.rb"

def check_extension(reader_file, writer_file)
  accepted_formats = '.precious'
  ext = File.extname(reader_file)
  if accepted_formats == ext
    open_file(reader_file)
  else
    raise 'This is not a *Gollum  Cough* *Gollum Cough* precious (file)!'
  end
end

def open_file(filename)
  file = File.open(filename)
  Parser.parse_file(file)
  file.close()
end

def destroy_output_file(writer_file)
  if File.exist?(writer_file)
    File.delete(writer_file)
  end
end

destroy_output_file(writer_file)
check_extension(reader_file, writer_file)

# try to run ruby file
# if you get an error
# caller_infos = caller.first.split(":")
# puts "#{caller_infos[0]} : #{caller_infos[1]} : #{str}"
# might need a mapper class that keeps track of which line nums match between files
