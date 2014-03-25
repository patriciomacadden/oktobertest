module Oktobertest
  VERSION = '0.0.1'

  TestFailed = Class.new StandardError
  TestSkipped = Class.new StandardError

  def self.run(files)
    files.each { |file| load file }
    puts
    errors.each do |error|
      case error
      when TestFailed
        file, line, _ = error.backtrace[2].split(':')
        print "\nerror: #{error.message}"
      when TestSkipped
        file, line, _ = error.backtrace[1].split(':')
        print "\nskip"
        print ": #{error.message}" unless error.message == error.class.name
      else
        file, line, _ = error.backtrace[0].split(':')
        print "\nerror: #{error.message}"
      end
      print "\nfile: #{file}\nline: #{line}\n"
    end
  end

  def self.run_test=(name)
    @run_test = name
  end

  def self.run_test
    @run_test
  end

  def self.run_scope=(name)
    @run_scope = name
  end

  def self.run_scope
    @run_scope
  end

  module Assertions
    def assert(value, message = nil)
      message ||= "condition is not true: #{value.inspect}"
      flunk message unless !!value
    end

    def assert_raises(exception, message = nil)
      begin
        yield
      rescue => error
      ensure
        message ||= "block doesn't raise #{exception}"
        flunk message unless error.kind_of? exception
      end
    end

    def flunk(message = nil)
      raise TestFailed, message
    end

    def skip(message = nil)
      raise TestSkipped, message
    end
  end

  class Scope
    def initialize(name = nil, &block)
      @name, @block = name, block
      @setup, @teardown = [], []
    end

    def run
      instance_eval &@block
    end

    protected

    def test(name = nil, &block)
      if !Oktobertest.run_test || Oktobertest.run_test == name
        test = Test.new(name, &block)
        singleton_methods.each { |m| test.define_singleton_method m, &method(m) }
        @setup.each { |b| test.instance_eval &b }
        test.run
        @teardown.each { |b| test.instance_eval &b }
      end
    end

    def setup(&block)
      @setup << block
    end

    def teardown(&block)
      @teardown << block
    end

    def scope(name = nil, &block)
      if !Oktobertest.run_scope || Oktobertest.run_scope == name
        scope = Scope.new(name, &block)
        singleton_methods.each { |m| scope.define_singleton_method m, &method(m) }
        @setup.each { |b| scope.setup &b }
        @teardown.each { |b| scope.teardown &b }
        scope.run
      end
    end
  end

  class Test
    include Assertions

    def initialize(name = nil, &block)
      @name, @block = name, block
    end

    def run
      instance_eval &@block
      print '.'
    rescue TestFailed => error
      Oktobertest.errors << error
      print 'F'
    rescue TestSkipped => error
      Oktobertest.errors << error
      print 'S'
    rescue StandardError => error
      Oktobertest.errors << error
      print 'E'
    end
  end

  private

  def self.errors
    @errors ||= []
  end
end

module Kernel
  def scope(name = nil, &block)
    if !Oktobertest.run_scope || Oktobertest.run_scope == name
      Oktobertest::Scope.new(name, &block).run
    end
  end
end
