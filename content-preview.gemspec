$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "content-preview/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "content-preview"
  s.version     = ContentPreview::VERSION
  s.authors     = ["Glyph"]
  s.email       = ["vala@glyph.fr"]
  s.homepage    = "http://glyph.fr"
  s.summary     = "A simple service for getting URL page informations"
  s.description = "A simple service for getting URL page informations"

  s.files       = [".gitignore", ".rspec", "Gemfile", "Gemfile.lock", "MIT-LICENSE", "Procfile", "README.md", "Rakefile", "bin/cp-server", "content-preview.gemspec", "js/src/content-preview.coffee", "lib/content-preview.rb", "lib/content-preview/parser.rb", "lib/content-preview/router.rb", "lib/content-preview/router/handlers/default.rb", "lib/content-preview/router/routes.yml", "lib/content-preview/version.rb", "lib/tasks/content-preview_tasks.rake", "spec/parser/parser_spec.rb", "spec/spec_helper.rb"]
  s.require_paths = ["lib"]
  # s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.bindir        = "bin"
  s.executables   = 'cp-server'

  s.add_dependency 'thor'
  s.add_dependency 'nokogiri'
  s.add_dependency 'rake'
  s.add_dependency 'rack-cors'
  s.add_dependency 'rack-test'
  s.add_dependency 'json'
end
