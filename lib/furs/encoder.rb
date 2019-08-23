module Furs
	class Encoder

		def initialize payload, header, key
			@algorithm = Furs::Constant::ALGORITHM
			@payload = payload
			@header = header
			@key = key
			@header[:alg] = @algorithm if @header.present?
		end

		def token
			combine encoded_header_and_payload, encoded_signature
		end

		def zoi
			Digest::MD5.hexdigest( sign @payload )
		end

		private

		def combine *parts
			parts.join "."
		end

		def encoded_header
			@encoded_header ||= encode64 @header.to_json
		end

		def encoded_payload
			@encoded_payload ||= encode64 @payload.to_json
		end

		def encoded_header_and_payload
			@encoded_header_and_payload ||= combine encoded_header, encoded_payload
		end

		def sign str
			@key.sign( OpenSSL::Digest.new(@algorithm.gsub('RS', 'sha')), str )	# sha256 = RS256!
		end

		def encoded_signature
			@encoded_signature ||= encode64( sign encoded_header_and_payload )
		end

		def encode64 str
			Base64.urlsafe_encode64 str
		end
	end
end