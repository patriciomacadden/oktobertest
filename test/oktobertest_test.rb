scope do
  test 'successful run' do
    expected = ".\n"
    output = %x(bin/ok test/fixtures/successful_test.rb)
    assert expected == output
  end

  test 'errored run' do
    expected = <<EOS
E

error: RuntimeError
file: test/fixtures/error_test.rb
line: 2
EOS
    output = %x(bin/ok test/fixtures/error_test.rb)
    assert expected == output
  end

  test 'failed run' do
    expected = <<EOS
F

error: condition is not true: false
file: test/fixtures/failing_test.rb
line: 2
EOS
    output = %x(bin/ok test/fixtures/failing_test.rb)
    assert expected == output
  end

  test 'run with skipped tests' do
    expected = <<EOS
S

skip
file: test/fixtures/skipped_test.rb
line: 2
EOS
    output = %x(bin/ok test/fixtures/skipped_test.rb)
    assert expected == output
  end

  test 'run only one scope' do
    expected = "..\n"
    output = %x(bin/ok -s 'run this' test/fixtures/run_scope_test.rb)
    assert expected == output
  end

  test 'run only one test' do
    expected = ".\n"
    output = %x(bin/ok -t 'run this' test/fixtures/run_test_test.rb)
    assert expected == output
  end
end
