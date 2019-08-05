module Furs
  class Configuration

    attr_accessor :base_url, :certificate_path, :certificate_password, :tls_ca_path, :sign_cert, :tax_number
    # :tls_cert_path

    def initialize
      @base_url = ENV['FURS_BASE_URL'] || "https://blagajne-test.fu.gov.si:9002"
      @certificate_path = ENV['FURS_CERTIFICATE_PATH']
      @certificate_password = ENV['FURS_CERTIFICATE_PASSWORD']
      # @tls_cert_path = ENV['FURS_TLS_CERT_PATH']      # might not be needed!!
      @tls_ca_path = ENV['FURS_TLS_CA_PATH']
      @sign_cert = ENV['FURS_SIGN_CERT']
      @tax_number = ENV['FURS_TAX_NUMBER']
    end

  end
end