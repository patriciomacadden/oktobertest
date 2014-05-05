require 'optparse'

module Oktobertest
  VERSION = '0.1.0'

  TestFailed = Class.new StandardError
  TestSkipped = Class.new StandardError

  def self.display_errors
    puts
    errors.each do |error|
      case error
      when TestFailed
        file, line, _ = error.backtrace[2].split ':'
        print "\nerror: #{error.message}"
      when TestSkipped
        file, line, _ = error.backtrace[1].split ':'
        print "\nskip"
      else
        file, line, _ = error.backtrace[0].split ':'
        print "\nerror: #{error.message}"
      end
      print "\nfile: #{file}\nline: #{line}\n"
    end
  end

  def self.errors
    @errors ||= []
  end

  def self.options
    @options ||= {}
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

    def skip
      raise TestSkipped
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

    def run?
      !Oktobertest.options[:run_scope] || Oktobertest.options[:run_scope] == @name
    end

    protected

    def test(name = nil, &block)
      test = Test.new name, &block
      public_methods(false).reject { |m| m == :run || m == :run? }.each { |m| test.define_singleton_method m, &method(m) }
      if test.run?
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
      scope = Scope.new name, &block
      singleton_methods.each { |m| scope.define_singleton_method m, &method(m) }
      @setup.each { |b| scope.setup &b }
      @teardown.each { |b| scope.teardown &b }
      scope.run if scope.run?
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
      print 'F'
    rescue TestSkipped => error
      print 'S'
    rescue StandardError => error
      print 'E'
    ensure
      Oktobertest.errors << error unless error.nil?
    end

    def run?
      !Oktobertest.options[:run_test] || Oktobertest.options[:run_test] == @name
    end
  end
end

module Kernel
  private

  def scope(name = nil, &block)
    scope = Oktobertest::Scope.new name, &block
    scope.run if scope.run?
  end
end

OptionParser.new do |opts|
  opts.on('--scope NAME', 'Run the NAME scope(s)') { |name| Oktobertest.options[:run_scope] = name }
  opts.on('--test NAME', 'Run the NAME test(s)') { |name| Oktobertest.options[:run_test] = name }
end.parse!

at_exit { Oktobertest.display_errors }
