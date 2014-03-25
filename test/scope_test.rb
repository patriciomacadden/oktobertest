scope do
  def foo
    'foo'
  end

  test 'responds to foo' do
    assert foo == 'foo'
  end

  scope do
    test 'responds to foo too' do
      assert foo == 'foo'
    end
  end
end

scope do
  setup do
    @foo = 'foo'
  end

  scope do
    setup do
      @bar = 'bar'
    end

    test 'foo and bar must be defined' do
      assert @foo == 'foo'
      assert @bar == 'bar'
    end
  end

  test 'foo must be defined and bar wont be' do
    assert @foo == 'foo'
    assert @bar.nil?
  end
end
