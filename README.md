# Oktobertest

Small test library.

## Why?

This is a project I started over the weekend. I was looking at [Cutest](https://github.com/djanowski/cutest)
and I thought: "It shouldn't be so difficult to make a test library".

### Features

* Setup - Test - Teardown model.
* Each `test` is an instance of `Oktobertest::Test`, which means that each test
runs its own context.
* Each `scope` is an instance of `Oktobertest::Scope`. Methods defined in a
scope are copied into each `test` it contains.
* Extensible: it's easy to add more assertions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oktobertest', group: :test
# or this if you want to use oktobertest master
# gem 'oktobertest', group: :test, github: 'patriciomacadden/oktobertest'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install oktobertest
```

## Usage

### Example

```ruby
scope do
  setup do
    @foo = 'foo'
  end

  test 'this test will pass' do
    assert @foo == 'foo'
  end

  test 'this test will pass too' do
    assert_raises RuntimeError do
      raise RuntimeError
    end
  end

  test 'this test will fail' do
    flunk 'fail!'
  end

  test 'skip this one!' do
    skip
  end
end
```

### Assertions

For now there are 2 assertions:

* `assert`: fails unless the given condition is true.
* `assert_raises`: fails unless the given block raises the given exception.

And there is a way of making tests fail (`flunk`) and skipping them (`skip`).

#### How to add assertions?

That's quite simple. Just define them in the `Oktobertest::Assertions` module:

```ruby
module Oktobertest
  module Assertions
    def assert_equal(expected, actual, message = nil)
      message ||= "#{expected.inspect} is not equal to #{actual.inspect}"
      assert expected == actual, message
    end
  end
end
```

### Running the test suite

You can run the test suite using `rake` or the `ok` command.

Using `rake`:

```ruby
require 'oktobertest'

task :test do
  Oktobertest.run Dir['test/*_test.rb']
end

task default: :test
```

Using `ok`:

```bash
$ ok test/*_test.rb
```

Please check the default options by running `ok`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See the [LICENSE](https://github.com/patriciomacadden/oktobertest/blob/master/LICENSE).
