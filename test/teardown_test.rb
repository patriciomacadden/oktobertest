require 'helper'

scope do
  setup do
    @foo = 'foo'
  end

  test 'after this test @foo is changed' do
    @foo = 'bar'
  end

  teardown do
    assert @foo == 'bar'
    @foo == 'baz'
  end

  teardown do
    assert @foo == 'baz'
  end
end
