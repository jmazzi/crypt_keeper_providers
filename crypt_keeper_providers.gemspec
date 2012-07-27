# -*- encoding: utf-8 -*-
require File.expand_path('../lib/crypt_keeper_providers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Justin Mazzi"]
  gem.email         = ["jmazzi@gmail.com"]
  gem.description   = %q{Encryption providers for crypt_keeper}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "crypt_keeper_providers"
  gem.require_paths = ["lib"]
  gem.version       = CryptKeeperProviders::VERSION

  gem.add_development_dependency 'rspec', '~> 2.10.0'
  gem.add_development_dependency 'guard', '~> 1.2.0'
  gem.add_development_dependency 'guard-rspec', '~> 1.1.0'
  gem.add_development_dependency 'rake', '~> 0.9.2.2'

end
