require 'spec_helper'

RSpec.describe Furs::Encoder do

	let(:private_key) do 
		path = File.expand_path("resources/private-key-test.pem", File.dirname(__dir__))
		OpenSSL::PKey::RSA.new File.read(path), 'testpass'
	end

	it 'generates the correct token' do
		payload = { payload: :test }
		header = { header: :test, alg: 'RS256' }

		encoder = Furs::Encoder.new payload, header, private_key
		token = encoder.token

		expect(token).to eq("eyJoZWFkZXIiOiJ0ZXN0IiwiYWxnIjoiUlMyNTYifQ==.eyJwYXlsb2FkIjoidGVzdCJ9.ZI0oNOOy-guiX7Qc62SYWn_XdsKDT2GTNfIdYTi1J_K2gPjxd8pUvXqWxvXOkOv3Ou_NaPjiJL52phVKAX6_vrpYIvwLIBsOc43jl3Xuts44rlZcaoxIgXM8ipn0PYFxSx-7Qm_y2mWGYVOHjFaL2lznQAePNCGmeJmONtbib9vUZNKCKhXXfZF5QxlFVhm9vb2MRq9Lc5kj-4ynA_wmskpO9y8OpPYD42y1b9FsPhuYdyOieVOoi7GT9amujv56d0tSqTuYm6skcx9qdR6m5efol6c_llztkCyZfY-LSyGNTt7sQTNHxW2hjFqEe6IWlsTIO5kKIM6DkOE4QR37nw==")
	end

end