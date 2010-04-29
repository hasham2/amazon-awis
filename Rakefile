require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/packagetask'

begin
	require 'jeweler'
	Jeweler::Tasks.new do |gemspec| 
		gemspec.name = "gaiottino-amazon-awis"
		gemspec.summary = "Ruby Amazon Alexa web information service REST API"
		gemspec.description = "Ruby Amazon Alexa web information service REST API"
		gemspec.email = "daniel.gaiottino@gmail.com"
		gemspec.homepage = "http://github.com/gaiottino/amazon-awis"
		gemspec.authors = ["Daniel Gaiottino"]
		gemspec.add_dependency('hpricot', '>= 0.4')
	end
	Jeweler::GemcutterTasks.new
rescue LoadError
	puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

desc "Run the unit tests in test" 
Rake::TestTask.new(:test) do |t|
	t.libs << "test" 
	t.pattern = 'test/**/*_test.rb'
	t.verbose = true
end