require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the isbn_validation plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the isbn_validation plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'IsbnValidation'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

spec = Gem::Specification.new do |s|
  s.name        = %q{isbn_validation}
  s.name        = %q{isbn_validation}
  s.version     = "0.1.2"
  s.summary     = %q{isbn_validation adds an isbn validation routine to active record models.}
  s.description = %q{isbn_validation adds an isbn validation routine to active record models.}

  s.files        = FileList['[A-Z]*', '{lib,test}/**/*.rb']
  s.require_path = 'lib'
  s.test_files   = Dir[*['test/**/*_test.rb']]

  s.has_rdoc         = true
  s.extra_rdoc_files = ["README"]
  s.rdoc_options = ['--line-numbers', '--inline-source', "--main", "README"]

  s.authors = ["Nick Plante"]
  s.email   = %q{nap@zerosum.org}

  s.platform = Gem::Platform::RUBY
  s.add_dependency(%q<activerecord>, [">= 2.1.2"])
end

desc "Generate a gemspec file"
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
