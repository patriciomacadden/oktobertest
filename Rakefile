require 'bundler/gem_tasks'

desc 'Run the tests'
task :test do
  require Pathname.new(__FILE__).dirname.join('test/helper')
  Oktobertest.run Dir['test/*_test.rb']
end

task default: :test
