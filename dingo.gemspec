Gem::Specification.new do |gem|
  gem.authors       = ["JaredShay"]
  gem.email         = ["jared.shay@gmail.com"]
  gem.description   = %q{Generate true blue copy}
  gem.summary       = %q{Generate true blue copy}
  gem.homepage      = "https://github.com/jaredshay/dingo"

  gem.files         = Dir["{lib,test}/**/*.rb"] + Dir["word_lists/*.txt"]+ %w(README.md)
  gem.name          = "dingo"
  gem.require_paths = ["lib"]
  gem.version       = '1.2.0'
end
