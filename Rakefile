require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "social_engine"
  gem.homepage = "http://github.com/johnmcaliley/social_engine"
  gem.license = "MIT"
  gem.summary = %Q{social_engine}
  gem.description = %Q{social_engine}
  gem.email = "john@couponshack.com"
  gem.authors = ["John McAliley"]
  gem.add_dependency "yettings"
  gem.add_dependency "inherited_resources"
  gem.add_dependency "haml"
  gem.add_dependency "formtastic"  
  gem.files.exclude "test_app"
  gem.files.exclude ".autotest"
  gem.files.exclude ".document"
  gem.files.exclude "Rakefile"
  gem.files.exclude "README.md"
  gem.files.exclude "license.txt"
  gem.files.exclude "Gemfile.lock"
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "social_engine #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.include('app/**/*.rb')
end
