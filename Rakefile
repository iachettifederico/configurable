#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

task :default => 'test'

Rake::TestTask.new  do |t|
  t.libs.push "lib"
  t.test_files = FileList['**/*_spec.rb']
  t.verbose = false
end
