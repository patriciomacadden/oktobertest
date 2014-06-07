require 'helper'

scope do
  test do
    @foo = 'foo'
    assert @foo == 'foo'
  end

  test '@foo is not defined' do
    assert @foo.nil?
  end
end
