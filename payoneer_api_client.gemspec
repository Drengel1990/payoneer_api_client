
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payoneer_api_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'payoneer_api_client'
  spec.version       = PayoneerApiClient::VERSION
  spec.authors       = ['Kirill Holodyuk']
  spec.email         = ['kirill.holodyuk@gmail.com']

  spec.summary       = 'Payoneer SDK for ruby.'
  spec.description   = 'Payoneer SDK for ruby.'
  spec.homepage      = 'https://github.com/Drengel1990/payoneer_api_client'
  spec.license       = 'MIT'

  spec.extra_rdoc_files = ['README.md']

  spec.required_ruby_version = '~> 2.2'

  spec.add_dependency 'rest-client', '>= 2.1'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
