scope 'assert' do
  test 'passes if the value is true' do
    assert true
  end

  test 'fails if the value is false' do
    assert_raises Oktobertest::TestFailed do
      assert false
    end
  end
end

scope 'assert_raises' do
  test 'passes if the block raises the given exception' do
    assert_raises RuntimeError do
      raise RuntimeError
    end
  end

  test 'fails if the block does not raise the given exception' do
    assert_raises Oktobertest::TestFailed do
      assert_raises RuntimeError do
        raise ArgumentError
      end
    end
  end
end

scope 'flunk' do
  test 'raises Oktobertest::TestFailed exception' do
    assert_raises Oktobertest::TestFailed do
      flunk
    end
  end
end

scope 'skip' do
  test 'raises Oktobertest::TestSkipped exception' do
    assert_raises Oktobertest::TestSkipped do
      skip
    end
  end
end
