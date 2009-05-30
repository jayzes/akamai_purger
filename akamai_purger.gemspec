# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{akamai_purger}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jay Zeschin"]
  s.date = %q{2009-05-29}
  s.default_executable = %q{akamai_purge}
  s.email = %q{jay.zeschin@factorylabs.com}
  s.executables = ["akamai_purge"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "akamai_purger.gemspec",
     "bin/akamai_purge",
     "lib/akamai_purger.rb",
     "test/akamai_purger_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/jayzes/akamai_purger}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Simple gem for purging Akamai URLs}
  s.test_files = [
    "test/akamai_purger_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<soap4r>, [">= 0"])
    else
      s.add_dependency(%q<soap4r>, [">= 0"])
    end
  else
    s.add_dependency(%q<soap4r>, [">= 0"])
  end
end
