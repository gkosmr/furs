require 'simplecov'

SimpleCov.start do
  add_filter '/spec/' 
end

require "bundler/setup"
require "furs"
require 'webmock/rspec'
require "vcr"
require "factory_bot"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

def configure_test_data
  Furs.configure do |config|
    config.base_url = 'https://blagajne-test.fu.gov.si:9002'
    config.certificate_path = File.expand_path("spec/resources/certificate-test.p12", File.dirname(__dir__))
    config.certificate_password = 'passtest'
    config.tls_ca_path = File.expand_path("spec/resources/ca-test.pem", File.dirname(__dir__))
    config.sign_cert = File.expand_path("spec/resources/sign-test.cer", File.dirname(__dir__))
    config.tax_number = 10523766
  end
end

configure_test_data