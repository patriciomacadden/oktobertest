require 'oktobertest'

scope 'run this' do
  test 'run this' do
    assert true
  end

  test 'and this' do
    assert true
  end
end

scope 'and not this' do
  test 'run this' do
    assert false
  end

  test 'and this' do
    assert false
  end
end

module Run
  class This
  end
end

scope Run::This do
  test 'run this' do
    assert true
  end

  test 'and this' do
    assert true
  end
end
