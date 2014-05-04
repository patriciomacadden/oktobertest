require 'helper'

scope 'assert' do
  test 'passes if the value is true' do
    assert true
  end

  test 'fails if the value is false' do
    assert_raises(Oktobertest::TestFailed) { assert false }
  end
end

scope 'assert_raises' do
  test 'passes if the block raises the given exception' do
    assert_raises(RuntimeError) { raise RuntimeError }
  end

  test 'fails if the block does not raise the given exception' do
    assert_raises Oktobertest::TestFailed do
      assert_raises(RuntimeError) { raise ArgumentError }
    end
  end
end

scope 'flunk' do
  test 'raises Oktobertest::TestFailed exception' do
    assert_raises(Oktobertest::TestFailed) { flunk }
  end
end

scope 'skip' do
  test 'raises Oktobertest::TestSkipped exception' do
    assert_raises(Oktobertest::TestSkipped) { skip }
  end
end
