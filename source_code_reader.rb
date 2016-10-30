def read_code(filename = $0)
  code_string = (File.read filename).to_s
  puts code_string
end

read_code