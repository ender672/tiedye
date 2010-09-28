require File.expand_path("../lib/tiedye/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "tiedye"
  s.version     = TieDye::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Timothy Elliott"]
  s.email       = ["tle@holymonkey.com"]
  s.homepage    = "http://github.com/ender672/tiedye"
  s.summary     = "A high-level image and color library"
  s.description = "tiedye provides fast image processing methods wrapped in a simple API"

  s.required_rubygems_version = ">= 1.3.6"

  s.rubyforge_project         = "tiedye"

  s.add_dependency "ruby-vips", "~> 0.1.0"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ["tiedye"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end
