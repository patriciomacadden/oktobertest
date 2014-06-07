require 'helper'

scope do
  setup do
    @foo = 'foo'
  end

  test 'foo is defined' do
    assert @foo == 'foo'
  end

  scope do
    test 'foo is defined' do
      assert @foo == 'foo'
    end
  end
end

scope do
  setup do
    @foo = 'foo'
  end

  test 'foo is defined' do
    assert @foo == 'foo'
    @foo = 'bar'
  end

  test 'foo has not changed' do
    assert @foo == 'foo'
  end
end

scope do
  setup do
    @foo = 'foo'
  end

  setup do
    @bar = 'bar'
  end

  test 'foo and bar are defined, but baz is not' do
    assert @foo == 'foo'
    assert @bar == 'bar'
    assert @baz.nil?
  end

  setup do
    @baz = 'baz'
  end

  test 'foo, bar and baz are defined' do
    assert @foo == 'foo'
    assert @bar == 'bar'
    assert @baz == 'baz'
  end
end
