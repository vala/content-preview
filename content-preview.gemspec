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

  s.files       = `git ls-files`.split("\n")
  s.add_dependency 'nokogiri'
  s.require_paths = ["lib"]
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
end
