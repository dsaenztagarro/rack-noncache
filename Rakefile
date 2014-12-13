require 'bundler/gem_tasks'

require 'cucumber'
require 'cucumber/rake/task'
require 'rubocop/rake_task'

require 'pry'

Dir.glob('lib/tasks/*.rake').each { |path| load path }

RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-rspec'
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format pretty'
end

task default: ['features']
