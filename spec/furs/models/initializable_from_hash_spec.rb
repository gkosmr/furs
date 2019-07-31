require 'spec_helper'

RSpec.describe Furs::Models::InitializableFromHash do

	it '#initialize_from_hash method converts hash to object correctly' do 
		uuid = SecureRandom.uuid
		data = { "Header" => { "MessageID" => uuid, "DateTime" => "2019-09-08T08:00:00" }, "Error" => { "ErrorCode" => "S002", "ErrorMessage" => "Error!!!" } }

		obj = Furs::Models::BusinessPremiseResponse.initialize_from_hash data
		expect(obj.header).not_to be(nil)		
		expect(obj.header.message_i_d).to eq(uuid)		
		expect(obj.error).not_to be(nil)		
		expect(obj.error.error_code).to eq("S002")		
	end
end