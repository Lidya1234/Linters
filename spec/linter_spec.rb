require_relative '../lib/linter_checks.rb'
describe 'LinterCheck' do
  let(:lint_spec) { LinterCheck.new('../Lint_bugs/bugs.java') }

  it '#check_trailing_space' do
    lint_spec.check_trailing_space
    expect(lint_spec.err[0]).eql? '../Lint_bugs/bugs.java :Lint/Syntax: Trailing whitespace detected'
  end
  it '#check_tags' do
    lint_spec.check_tags
    expect(lint_spec.err[0]).eql? '../Lint_bugs/bugs.java :Lint/Syntax: Missing or unexpected token Braces'
  end
  it '#check_empty_line' do
    lint_spec.check_empty_line
    expect(lint_spec.err[0]) != '../Lint_bugs/bugs.java :Lint/Syntax: Missing or unexpected token Braces'
  end
  it '#check_empty_line' do
    lint_spec.check_empty_line
    expect(lint_spec.err[0]) != '../Lint_bugs/bugs.java :Lint/Syntax: Empty line at the begning of a class'
  end
  it '#check_semicolon' do
    lint_spec.check_semicolon
    expect(lint_spec.err[0]).eql? '../Lint_bugs/bugs.java :Lint/Syntax: Missing semicolon '
  end
  it '#check_semicolon' do
    lint_spec.check_semicolon
    expect(lint_spec.err[0]) != '../Lint_bugs/bugs.java :Lint/Syntax: Missing semicolon '
  end
end
