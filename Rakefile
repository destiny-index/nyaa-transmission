require 'rake/testtask'

Rake::TestTask.new do |t|
  t.warning = false
end

task :test do
  `date >> /tmp/test_runs`
end

task :default => :test
