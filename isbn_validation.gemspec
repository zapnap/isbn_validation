# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "isbn_validation/version"

Gem::Specification.new do |s|
  s.name = %q{isbn_validation}
  s.version = IsbnValidation::VERSION
  s.summary = %q{isbn_validation adds an isbn validation routine to active record models.}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Plante"]
  s.date = %q{2009-09-10}
  s.description = %q{isbn_validation adds an isbn validation routine to active record models.}
  s.email = %q{nap@zerosum.org}

  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options = ["--line-numbers", "--inline-source", "--main", "README.md"]

  s.files = ["MIT-LICENSE", "Rakefile", "README.md", "lib/isbn_validation/version.rb", "lib/isbn_validation.rb", "test/isbn_validation_test.rb", "test/models.rb", "test/schema.rb", "test/test_helper.rb"]
  s.test_files = ["test/isbn_validation_test.rb"]
  s.require_paths = ["lib"]

  s.add_dependency(%q<activerecord>, [">= 3"])
  s.add_development_dependency("sqlite3")
end
