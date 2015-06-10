# -*- encoding: utf-8 -*-

require File.expand_path("../lib/thincloud/messagebus/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "thincloud-messagebus"
  gem.version       = Thincloud::Messagebus::VERSION
  gem.summary       = "A simple message bus"
  gem.description   = "A simple message bus"
  gem.license       = "MIT"
  gem.authors       = ["Don Morrison", "John Dell"]
  gem.email         = ["dmorrison@newleaders.com", "jdell@newleaders.com"]
  gem.homepage      = "https://github.com/newleaders/thincloud-messagebus#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "event_bus", "~> 1.0"

  gem.add_development_dependency "activesupport", ">= 3.2"
  gem.add_development_dependency "bundler", "~> 1.2"
  gem.add_development_dependency "minitest", "~> 5.0"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rubygems-tasks", "~> 0.2"
  gem.add_development_dependency "yard", "~> 0.8"
end
