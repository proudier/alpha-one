# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "alpha-one"
  spec.version       = "0.4.1"
  spec.authors       = ["Pierre ROUDIER"]
  spec.email         = ["pierre@roudier.io"]

  spec.summary       = %q{A Jekyll theme designed for enhanced readability of (long) blog posts}
  spec.homepage      = "https://github.com/proudier/alpha-one"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(assets|_(includes|layouts|sass)/|(LICENSE|README)((\.(txt|md|markdown)|$)))}i)
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_runtime_dependency "jekyll", "~> 3.3"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
