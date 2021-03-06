
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "furs/version"

Gem::Specification.new do |spec|
  spec.name          = "furs"
  spec.version       = Furs::VERSION
  spec.authors       = ["Gašper Košmrlj"]
  spec.email         = ["gasperk@abelium.eu"]

  spec.summary       = %q{FURS fiscal verification of invoices}
  spec.description   = %q{Service wrapper to verify invoices on Financial administration of Republic of Slovenia.}
  #spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  #   spec.metadata["homepage_uri"] = spec.homepage
  #   spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #   spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 5.0.0"
  spec.add_development_dependency "webmock", "~> 3.6.0"
  spec.add_development_dependency "factory_bot", "~> 5.0.2"
  spec.add_development_dependency "simplecov", "~> 0.17.0"
  
  spec.add_dependency "json", "~> 2.2.0"
  spec.add_dependency "httparty", "~> 0.17.0"
  spec.add_dependency "activesupport"
  spec.add_dependency "activemodel"
end
