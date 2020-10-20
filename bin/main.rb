  #!/usr/bin/env ruby
  require_relative '../lib/linter_checks.rb'
  lint_check = ReadFile.new(ARGV.first)
  lint_check.check_trailing_space
  lint_check.check_tags
  lint_check.check_empty_line
  if lint_check.err.empty? && lint_check.file_check.err_msg.empty?
    puts 'No error found'
  elsif !lint_check.file_check.err_msg.empty?
    puts lint_check.file_check.err_msg
  else
    lint_check.err.each do |err| {puts err}
 end