require_relative '../lib/linter_checks.rb'
describe 'LinterCheck' do
let (:lint_spec) {LinterCheck.new('../bin/jbug.java')}

it '#check_trailing_space' do
lint_spec.check_trailing_space
expect(lint_spec.err[0]).eql? 'jbug.java : Trailing whitespace detected'

end
it '#check_tags' do
    lint_spec.check_tags
    expect(lint_spec.err[0]).eql? 'jbug.java : :Lint/Syntax: Missing or unexpected token Braces'
    
    end
    it '#check_empty_line' do
        lint_spec.check_empty_line
        expect(lint_spec.err[0]) != 'jbug.java : :Lint/Syntax: Missing or unexpected token Braces'
        
        end    
end