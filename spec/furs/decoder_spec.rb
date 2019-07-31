require 'spec_helper'

RSpec.describe Furs::Decoder do

	let(:public_key_path) do
		File.expand_path("resources/public-key-test.pem", File.dirname(__dir__))
	end

	let(:incorrect_public_key_path) do
		File.expand_path("resources/wrong-public-key-test.cer", File.dirname(__dir__))
	end

	it 'decodes the right header and payload' do
		token = "eyJoZWFkZXIiOiJ0ZXN0IiwiYWxnIjoiUlMyNTYifQ==.eyJwYXlsb2FkIjoidGVzdCJ9.ZI0oNOOy-guiX7Qc62SYWn_XdsKDT2GTNfIdYTi1J_K2gPjxd8pUvXqWxvXOkOv3Ou_NaPjiJL52phVKAX6_vrpYIvwLIBsOc43jl3Xuts44rlZcaoxIgXM8ipn0PYFxSx-7Qm_y2mWGYVOHjFaL2lznQAePNCGmeJmONtbib9vUZNKCKhXXfZF5QxlFVhm9vb2MRq9Lc5kj-4ynA_wmskpO9y8OpPYD42y1b9FsPhuYdyOieVOoi7GT9amujv56d0tSqTuYm6skcx9qdR6m5efol6c_llztkCyZfY-LSyGNTt7sQTNHxW2hjFqEe6IWlsTIO5kKIM6DkOE4QR37nw=="

		decoder = Furs::Decoder.new token, public_key_path
		header, payload = decoder.decode

		expect(JSON.parse header, symbolize_names: true).to eq({ header: 'test', alg: 'RS256' })
		expect(JSON.parse payload, symbolize_names: true).to eq({ payload: 'test' })
	end

	it 'fails verification when public key is wrong' do
		token = "eyJoZWFkZXIiOiJ0ZXN0IiwiYWxnIjoiUlMyNTYifQ==.eyJwYXlsb2FkIjoidGVzdCJ9.ZI0oNOOy-guiX7Qc62SYWn_XdsKDT2GTNfIdYTi1J_K2gPjxd8pUvXqWxvXOkOv3Ou_NaPjiJL52phVKAX6_vrpYIvwLIBsOc43jl3Xuts44rlZcaoxIgXM8ipn0PYFxSx-7Qm_y2mWGYVOHjFaL2lznQAePNCGmeJmONtbib9vUZNKCKhXXfZF5QxlFVhm9vb2MRq9Lc5kj-4ynA_wmskpO9y8OpPYD42y1b9FsPhuYdyOieVOoi7GT9amujv56d0tSqTuYm6skcx9qdR6m5efol6c_llztkCyZfY-LSyGNTt7sQTNHxW2hjFqEe6IWlsTIO5kKIM6DkOE4QR37nw=="

		decoder = Furs::Decoder.new token, incorrect_public_key_path
		expect{ decoder.decode }.to raise_error(Exceptions::JwtInvalidCertificate)
	end

	it 'fails verification when token has only two segments' do
		token = "eyJoZWFkZXIiOiJ0ZXN0IiwiYWxnIjoiUlMyNTYifQ==.eyJwYXlsb2FkIjoidGVzdCJ9"

		decoder = Furs::Decoder.new token, incorrect_public_key_path
		expect{ decoder.decode }.to raise_error(Exceptions::JwtDecodeError)
	end

end