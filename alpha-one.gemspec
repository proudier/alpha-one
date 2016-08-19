# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "alpha-one"
  spec.version       = "0.1.0"
  spec.authors       = ["Pierre ROUDIER"]
  spec.email         = ["contact@pierreroudier.net"]

  spec.summary       = %q{Another jekyll theme}
  spec.homepage      = "https://github.com/proudier/alpha-one"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(_layouts|_includes|_sass|LICENSE|README)/i}) }

  spec.add_development_dependency "jekyll", "~> 3.2"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
