example_name = 'script evaluator'
RSpec.shared_examples example_name do |parameter|
  it "script #{parameter}" do
    expect { system(command(parameter)) }.
      to output(expected_output(parameter)).
      to_stdout_from_any_process
  end
end

RSpec.describe 'Starfleet student grader' do
  DIR = File.dirname(__FILE__)
  FIXTURES = "#{DIR}/fixtures"
  INPUT = "#{FIXTURES}/input"
  OUTPUT = "#{FIXTURES}/output"

  def command(test_number)
    "ruby seval.rb grade \
    #{INPUT}/field.#{test_number} \
    #{INPUT}/script.#{test_number}"
  end

  def expected_output(test_number)
    open("#{OUTPUT}/#{test_number}").read
  end

  (1..5).each { |i| it_behaves_like example_name, i }
end