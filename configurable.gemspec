# -*- encoding: utf-8 -*-
require File.expand_path('../lib/configurable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Federico M. Iachetti"]
  gem.email         = ["iachetti.federico@gmail.com"]
  gem.description   = %q{Configure your objects}
  gem.summary       = %q{This gem allows you to grant your Ruby objects the ability to allow configurations}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "configurable"
  gem.require_paths = ["lib"]
  gem.version       = Configurable::VERSION

  # specify any dependencies here; for example:
  # s.add_development_dependency "minitest"
  # s.add_runtime_dependency "ostruct"
end
