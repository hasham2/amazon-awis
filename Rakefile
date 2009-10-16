require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/packagetask'

spec = Gem::Specification.new do |s| 
  s.name = "amazon-awis"
  s.version = "0.1.0"
  s.author = "Hasham Malik"
  s.email = "hasham2@gmail.com"
  s.homepage = "http://hasham2.blogspot.com/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby Amazon Alexa web information service REST API"
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "name"
  s.test_files = FileList["{test}/**/*test.rb"].to_a
  s.has_rdoc = false
  s.extra_rdoc_files = ["README", "CHANGELOG"]
  s.add_dependency("hpricot", ">= 0.4")  
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end

desc "Run the unit tests in test" 
Rake::TestTask.new(:test) do |t|
  t.libs << "test" 
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end