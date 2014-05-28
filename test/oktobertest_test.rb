require 'helper'

scope do
  test 'successful run' do
    expected = ".\n"
    output = %x(ruby -I lib:test test/fixtures/successful_test.rb)
    assert expected == output
  end

  test 'errored run' do
    expected = <<EOS
E

error: RuntimeError
file: test/fixtures/error_test.rb
line: 4
EOS
    output = %x(ruby -I lib:test test/fixtures/error_test.rb)
    assert expected == output
  end

  test 'failed run' do
    expected = <<EOS
F

error: condition is not true: false
file: test/fixtures/failing_test.rb
line: 4
EOS
    output = %x(ruby -I lib:test test/fixtures/failing_test.rb)
    assert expected == output
  end

  test 'run with skipped tests' do
    expected = <<EOS
S

skip
file: test/fixtures/skipped_test.rb
line: 4
EOS
    output = %x(ruby -I lib:test test/fixtures/skipped_test.rb)
    assert expected == output
  end

  test 'run only one scope' do
    expected = "..\n"
    output = %x(SCOPE='run this' ruby -I lib:test test/fixtures/run_scope_test.rb)
    assert expected == output
  end

  test 'run only one test' do
    expected = ".\n"
    output = %x(TEST='run this' ruby -I lib:test test/fixtures/run_test_test.rb)
    assert expected == output
  end
end
