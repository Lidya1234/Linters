require_relative 'file_reader.rb'

class LinterCheck
    attr_reader :file_check, :err
  def initialize(file_path)
    @file_check = ReadFile.new(file_path)
    @err = []
  end

  def check_indentation; end 

  def check_trailing_space
    @file_check.file_line.each_with_index do |string, index|
      if string.match(/\s*$/) && !string.strip.empty?
        @err << "#{@file_check.file_path} :#{index + 1} :#{string.size - 1}: Trailing whitespace detected"
      end
    end
  end

  def check_tags
    tags_error(/\(/, /\)/, '(', ')' ,'parenthesis')
    tags_error(/\{/, /\}/, '{', '}' ,'Braces')
    tags_error(/\[/, /\]/, '[', ']' ,'square_brackets')
  end

  def check_end; end

  def check_empty_line
    @file_check.file_line.each_with_index do |string, index|
      if string.strip.split(' ').first.eql('class')
        check_class_empty_line(string, index)
      elsif string.strip.split(' ').first.eql('def')
        check_method_empty_line(string, index)
      elsif string.strip.split(' ').include?('do')
        check_do_empty_line(string, index)
      end
    end
  end
  
  def tags_error(*param)
    opening_tag = []
    closing_tag = []
    @file_check.file_line.each_with_index do |string, index|
      opening_tag << string.scan(param[0])
      closing_tag << string.scan(param[1])
      check = opening_tag.size <=> closing_tag.size
      if check != 0
        error = "#{@file_check.file_path} :line #{index + 1} :Lint/Syntax: Missing or unexpected token #{param[4]}"
        @err << error
      end
    end
  end
  check_class_empty_line(string, index)
  def check_class_empty_line(string ,index)
    @err << "Empty line at the begning of a class: #{index + 2}" if @file_check.file_line[index + 1].strip.empty?
  end
  def check_method_empty_line(string ,index)
    @err << "Empty line at the begning of a method: #{index + 2}" if @file_check.file_line[index + 1].strip.empty?
  end
  def check_do_empty_line(string ,index)
    @err << "Empty line at the begning of a do block: #{index + 2}" if @file_check.file_line[index + 1].strip.empty?
  end
end
