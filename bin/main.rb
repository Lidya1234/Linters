#!/usr/bin/env ruby
require_relative '../lib/linter_checks.rb'

lint_check = LinterCheck.new(ARGV.first)
if !lint_check.file_check.err_msg.empty?
  puts lint_check.file_check.err_msg
else
  lint_check.check_trailing_space
  lint_check.check_tags
  lint_check.check_empty_line
  if lint_check.err.empty?
    puts 'No error found'
  else
    lint_check.err.each { |err| puts err }
  end
end
