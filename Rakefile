require 'bundler/gem_tasks'

require 'oktobertest'

desc 'Run the tests'
task :test do
  Oktobertest.run Dir['test/*_test.rb']
end

task default: :test
