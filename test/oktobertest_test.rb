require 'helper'

scope do
  scope 'successful run' do
    test 'output' do
      expected = ".\n"
      output = %x(ruby -I lib:test test/fixtures/successful_test.rb)
      assert expected == output
    end

    test 'exit status == 0' do
      %x(ruby -I lib:test test/fixtures/successful_test.rb)
      assert 0 == $?.exitstatus
    end
  end

  scope 'errored run' do
    test 'output' do
      expected = <<EOS
E

error: RuntimeError
file: test/fixtures/error_test.rb
line: 4
EOS
      output = %x(ruby -I lib:test test/fixtures/error_test.rb)
      assert expected == output
    end

    test 'exit status == 1' do
      %x(ruby -I lib:test test/fixtures/error_test.rb)
      assert 1 == $?.exitstatus
    end
  end

  scope 'failed run' do
    test 'output' do
      expected = <<EOS
F

error: condition is not true: false
file: test/fixtures/failing_test.rb
line: 4
EOS
      output = %x(ruby -I lib:test test/fixtures/failing_test.rb)
      assert expected == output
    end

    test 'exit status == 1' do
      %x(ruby -I lib:test test/fixtures/failing_test.rb)
      assert 1 == $?.exitstatus
    end
  end

  scope 'run with skipped tests' do
    test 'output' do
      expected = <<EOS
S

skip
file: test/fixtures/skipped_test.rb
line: 4
EOS
      output = %x(ruby -I lib:test test/fixtures/skipped_test.rb)
      assert expected == output
    end

    test 'exit status == 0' do
      %x(ruby -I lib:test test/fixtures/skipped_test.rb)
      assert 0 == $?.exitstatus
    end
  end

  test 'run only one scope' do
    expected = "..\n"
    output = %x(S='run this' ruby -I lib:test test/fixtures/run_scope_test.rb)
    assert expected == output
  end

  test 'run only one test' do
    expected = ".\n"
    output = %x(T='run this' ruby -I lib:test test/fixtures/run_test_test.rb)
    assert expected == output
  end
end
