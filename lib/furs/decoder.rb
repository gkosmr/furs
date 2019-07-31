module Furs
	class Decoder

		def initialize token, sign_cert_path, verify = true
			@algorithm = Furs::Constant::ALGORITHM
			@token = token
			@sign_cert_path = sign_cert_path
			@verify = verify
		end

		def decode
			verify_token_segments_count!
			verify_token_signature! if @verify
			[decode64(header_segment), decode64(payload_segment)]
		end

		private

		def segments
			@segments ||= @token.split('.')
		end

		def header_segment
			@header_segment ||= segments[0]
		end

		def payload_segment
			@payload_segment ||= segments[1]
		end

		def signature_segment
			@signature_segment ||= segments[2]
		end

		def decode64 str
			Base64.urlsafe_decode64 str
		end

		def verify_token_segments_count!
			fail(Exceptions::JwtDecodeError, 'Not enough or too many segments') if (@verify && segments.size != 3) || (!@verify && segments.size != 2)
		end

		def verify_token_signature!
			cert = OpenSSL::X509::Certificate.new File.read(@sign_cert_path)
			fail(Exceptions::JwtInvalidCertificate, 'Cannot verify the response') unless cert.public_key.verify(@algorithm.gsub('RS', 'sha'), decode64(signature_segment), [header_segment, payload_segment].join(".") ) 
		end
	end
end