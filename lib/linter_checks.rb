require_relative 'file_reader.rb'
attr_reader :file_check :err
class Linter_check
    def initialize(file_path)
  @file_check =ReadFile.new(file_path)
  @err =[]
    end
def check_indentation

end
def trailing_space
@file_check.file_line.each_with_index|string ,index|
{if string.match(\s*$) && !string.strip.empty?
@err << "#{@file_check.file_path} :#{index +1} :#{string.size-1}: Trailing whitespace detected" }
end
end
def check_tags
end
def check_end
end
def check_empty_line
end
end