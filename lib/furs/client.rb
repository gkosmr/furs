require 'httparty'

module Furs
	class Client
		include HTTParty
		ssl_version :TLSv1_2

		attr_reader :config

		HEADERS = { "Content-Type" => "application/json; charset=UTF-8" }
		ECHO_PATH = "/v1/cash_registers/echo"
		BUSINESS_PREMISE_PATH = "/v1/cash_registers/invoices/register"
		INVOICE_PATH = "/v1/cash_registers/invoices"

		def initialize config
			@config = config
		end

		# debug_output: $stdout
		def echo data
			request ECHO_PATH, data
		end

		def register_business_premise data
			signed_request BUSINESS_PREMISE_PATH, data, Furs::Models::BusinessPremiseResponse
		end

		def issue_invoice data
			data.invoice.generate_zoi!(p12) if data.invoice.present?
			signed_request INVOICE_PATH, data, Furs::Models::InvoiceResponse
		end

		private

			def request path, data
				fail(Exceptions::InvalidData, "Data is invalid: #{data.errors_hash}") unless data.valid?
				
				response = Furs::Client.post( 
					url(path), 
					headers: HEADERS, 
					body: data.to_json, 
					p12: File.read(config.certificate_path), 
					p12_password: config.certificate_password,
					cert_store: cert_store
				)
				JSON.parse(response.body)['EchoResponse']
			end

			def signed_request path, data, response_class
				fail(Exceptions::InvalidData, "Data is invalid: #{data.errors_hash}") unless data.valid?

				response = Furs::Client.post( 
					url(path), 
					headers: HEADERS, 
					body: body(data), 
					p12: File.read(config.certificate_path), 
					p12_password: config.certificate_password,
					cert_store: cert_store
					# debug_output: $stdout
				)
				h, p = Furs::Decoder.new(objectify(response.body).token, config.sign_cert).decode
				response_class.initialize_from_hash JSON.parse(p)[response_class.to_s.split('::').last]
			end

			def url path
				"#{config.base_url}#{path}"
			end

			def parse json
				JSON.parse(json).deep_transform_keys { |key| key.to_s.underscore }
			end

			def objectify data
				 JSON.parse (data.is_a?(Hash) ? data : parse(data)).to_json, object_class: OpenStruct
			end

			def p12
				@p12 ||= OpenSSL::PKCS12.new File.read(config.certificate_path), config.certificate_password
			end

			def body payload
				{ token: Furs::Encoder.new(payload, header, p12.key).token }.to_json
			end

			def header
				cert = p12.certificate
				{ alg: "RS256", subject_name: cert.subject.to_s(OpenSSL::X509::Name::RFC2253), issuer_name: cert.issuer.to_s(OpenSSL::X509::Name::RFC2253), serial: cert.serial.to_i }
			end

			def cert_store
				cert_store = OpenSSL::X509::Store.new
				cert_store.add_file(config.tls_ca_path)
				# cert = OpenSSL::X509::Certificate.new(File.read(config.tls_cert_path))
				# fail(Exceptions::CannotVerifyTls, 'Can\'t verify TLS CA') unless cert_store.verify(cert)
				# cert_store.add_file(config.tls_cert_path)
				cert_store
			end
	end
end