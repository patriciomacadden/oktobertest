require 'oktobertest'

scope do
  test 'run this' do
    assert true
  end

  test 'and not this' do
    assert false
  end
end

module Run
  class This
  end
end

scope do
  test Run::This do
    assert true
  end

  test 'and not this' do
    assert false
  end
end
