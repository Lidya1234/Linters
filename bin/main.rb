require_relative '../lib/linter_checks.rb'

lint_check = LinterCheck.new('../Lint_bugs/bugs.java')
if !lint_check.file_check.err_msg.empty?
  puts lint_check.file_check.err_msg
else
  lint_check.check_trailing_space
  lint_check.check_tags
  lint_check.check_empty_line
  lint_check.check_semicolon
  if lint_check.err.empty?
    puts 'No error found'
  else
    lint_check.err.uniq.each { |err| puts err }
  end
end
