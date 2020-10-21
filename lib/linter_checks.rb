require_relative 'file_reader.rb'

class LinterCheck
  attr_reader :file_check, :err
  def initialize(file_path)
    @file_check = ReadFile.new(file_path)
    @err = []
    @keywords = ['if', 'else', 'for', 'while', 'try', 'catch', '{', '}']
  end

  def check_semicolon
    @file_check.file_lines.each_with_index do |string, _index|
      next if @keywords.include?(string.split(' ').first) || string.strip.empty? || string.include?('class')

      string.strip!
      @err << "#{@file_check.filepath} :Lint/Syntax: Missing semicolon " if string[-1, 1] != ';'
    end
  end

  def check_trailing_space
    @file_check.file_lines.each_with_index do |string, _index|
      if string.match(/\s*$/) && !string.strip.empty?
        @err << "#{@file_check.filepath} :Lint/Syntax: Trailing whitespace detected"
      end
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
        error = "#{@file_check.filepath} :Lint/Syntax: Missing or unexpected token #{param[4]}"
        @err << error
      end
    end
  end

  def check_class_empty_line(_string, index)
    return unless @file_check.file_lines[index + 1].strip.empty?

    @err << "#{@file_check.filepath} :Lint/Syntax: Empty line at the begning of a class"
  end

  def check_method_empty_line(_string, index)
    return unless @file_check.file_lines[index + 1].strip.empty?

    @err << "#{@file_check.filepath} :Lint/Syntax: Empty line at the begning of a method"
  end

  def check_do_empty_line(_string, index)
    return unless @file_check.file_lines[index + 1].strip.empty?

    @err << "#{@file_check.filepath} :Empty line at the begning of a do block"
  end
end
