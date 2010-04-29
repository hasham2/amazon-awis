# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gaiottino-amazon-awis}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Gaiottino"]
  s.date = %q{2010-04-29}
  s.description = %q{Ruby Amazon Alexa web information service REST API}
  s.email = %q{daniel.gaiottino@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "gaiottino-amazon-awis.gemspec",
     "lib/amazon/awis.rb",
     "test/amazon/awis_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/gaiottino/amazon-awis}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ruby Amazon Alexa web information service REST API}
  s.test_files = [
    "test/amazon/awis_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.4"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.4"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.4"])
  end
end

