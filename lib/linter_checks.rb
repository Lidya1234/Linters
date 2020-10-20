require_relative 'file_reader.rb'

class LinterCheck
  attr_reader :file_check, :err
  def initialize(file_path)
    @file_check = ReadFile.new(file_path)
    @err = []
    @keywords = ['if', 'else', 'for', 'while', 'try', 'catch', '{', '}']
  end

  def check_semicolon
    @file_check.file_lines.each_with_index do |string, index|
      next if @keywords.include?(string.split(' ').first) || string.strip.empty? || string.include?('class')

      string.strip!
      @err << "#{@file_check.filepath} :#{index + 1} :Add semicolon " if string[-1, 1] != ';'
    end
  end

  def check_trailing_space
    @file_check.file_lines.each_with_index do |string, _index|
      @err << "#{@file_check.filepath} : Trailing whitespace detected" if string.match(/\s*$/) && !string.strip.empty?
    end
  end

  def check_tags
    tags_error(/\(/, /\)/, '(', ')', 'parenthesis')
    tags_error(/\{/, /\}/, '{', '}', 'Braces')
    tags_error(/\[/, /\]/, '[', ']', 'square_brackets')
  end

  def check_empty_line
    @file_check.file_lines.each_with_index do |string, index|
      if string.strip.split(' ').include?('class')
        check_class_empty_line(string, index)
      elsif string.strip.split(' ').first.eql?('def')
        check_method_empty_line(string, index)
      elsif string.strip.split(' ').include?('do')
        check_do_empty_line(string, index)
      end
    end
  end

  def tags_error(*param)
    opening_tag = []
    closing_tag = []
    @file_check.file_lines.each_with_index do |string, _index|
      opening_tag << string.scan(param[0])

      closing_tag << string.scan(param[1])

      check = opening_tag.flatten.length <=> closing_tag.flatten.length
      if check != 0
        error = "#{@file_check.filepath} : :Lint/Syntax: Missing or unexpected token #{param[4]}"
        @err << error
      end
    end
  end

  def check_class_empty_line(_string, index)
    @err << "Empty line at the begning of a class: #{index + 2}" if @file_check.file_lines[index + 1].strip.empty?
  end

  def check_method_empty_line(_string, index)
    @err << "Empty line at the begning of a method: #{index + 2}" if @file_check.file_lines[index + 1].strip.empty?
  end

  def check_do_empty_line(_string, index)
    @err << "Empty line at the begning of a do block: #{index + 2}" if @file_check.file_lines[index + 1].strip.empty?
  end
end
