# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name = %q{amazon-awis}
  s.version = "0.1.0"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hasham Malik"]
  s.date = %q{2009-10-16}
  s.description = %q{Ruby Amazon Alexa web information service REST API}
  s.email = %q{hasham2@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = [ "lib/amazon", "lib/amazon/awis.rb", "test/amazon", "test/amazon/awis_test.rb", "test/test_helper.rb", "README"]
  s.has_rdoc = false
  s.homepage = %q{http://hasham2.blogspot.com/}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby Amazon Alexa web information service REST API}
 
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
 
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end