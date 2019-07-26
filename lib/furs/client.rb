require 'httparty'

module Furs
	class Client
		include HTTParty
		ssl_version :TLSv1_2

		attr_reader :config

		HEADERS = { "Content-Type" => "application/json; charset=UTF-8" }
		ECHO_PATH = "/v1/cash_registers/echo"
		BUSINESS_PREMISE_PATH = "/v1/cash_registers/invoices/register"

		def initialize config
			@config = config
		end

		# debug_output: $stdout
		def echo data
			response = Furs::Client.post( 
				url(ECHO_PATH), 
				headers: HEADERS, 
				body: data.to_json, 
				p12: File.read(config.certificate_path), 
				p12_password: config.certificate_password,
				cert_store: cert_store
			)
			objectify(response.body)
		end

		def register_business_premise data
			response = Furs::Client.post( 
				url(BUSINESS_PREMISE_PATH), 
				headers: HEADERS, 
				body: body(data), 
				p12: File.read(config.certificate_path), 
				p12_password: config.certificate_password,
				cert_store: cert_store
				# debug_output: $stdout
			)
			header, payload = Furs::Decoder.new(objectify(response.body).token, config.sign_cert).decode

			parsed_header = parse(header)
			parsed_payload = parse(payload)

			validate_result! parsed_payload

			objectify({ header: parsed_header, payload: parsed_payload })
		end

		def issue_invoice data
			fail Exceptions::NotImplemented
		end

		private

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

			def validate_result! data
				error_data = data['business_premise_response']['error']
				fail(Exceptions::ResponseError, "#{error_data['error_code']} | #{error_data['error_message']}") if error_data.present?
			end
	end
end