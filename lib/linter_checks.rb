require_relative 'file_reader.rb'
attr_reader :file_check , :err
class Linter_check
    def initialize(file_path)
  @file_check =ReadFile.new(file_path)
  @err =[]
    end
def check_indentation

end
def check_trailing_space
@file_check.file_line.each_with_index|string ,index|
{if string.match(/\s*$/) && !string.strip.empty?
@err << "#{@file_check.file_path} :#{index +1} :#{string.size-1}: Trailing whitespace detected"
end
}

end
def check_tags
    tags_error(/\(/ ,/\)/ ,'(' ,')')
    tags_error(/\{/ ,/\}/ ,'{' ,'}')
    tags_error(/\[/ ,/\]/ ,'[' ,']')

end
def check_end
end
def check_empty_line
end

def tags_error(*param)
    opening_tag =[]
    closing_tag =[]
    @file_check.file_line.each_with_index|string ,index| do
        opening_tag << string.scan(arg[0]) 
        closing_tag << string.scan(arg[1])
        check = opening_tag.flatten.size <=> closing_tag.flatten.size
        if check == 1 || check == -1
            error= "#{@file_check.file_path} :line #{index +1} :Lint/Syntax: Missing or unexpected token"
         @err << error
        end
    end
 
    
end
end