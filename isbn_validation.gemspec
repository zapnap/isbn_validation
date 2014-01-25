# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "isbn_validation/version"

Gem::Specification.new do |s|
  s.name    = "isbn_validation"
  s.version = IsbnValidation::VERSION
  s.summary = "isbn_validation adds an isbn validation routine to active record models."
  s.authors = ["Nick Plante"]
  s.email   = ["nap@zerosum.org"]
  s.description = "isbn_validation adds an isbn validation routine to active record models."
  s.homepage = 'https://github.com/zapnap/isbn_validation'

  s.extra_rdoc_files = %w(README.md MIT-LICENSE)
  s.files            = Dir.glob("lib/**/*") + %w(README.md MIT-LICENSE)

  s.add_dependency(%q<activerecord>, [">= 3"])
  s.add_development_dependency("sqlite3")
end
