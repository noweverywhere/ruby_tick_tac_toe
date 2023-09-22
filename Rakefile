require 'rake/testtask'

task default: 'test'
Rake::TestTask.new do |task|
  task.pattern = 'test/*_test.rb'
end

task :play do
  ruby './play.rb'
end
