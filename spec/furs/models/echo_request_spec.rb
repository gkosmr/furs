require 'spec_helper'

RSpec.describe Furs::Models::EchoRequest do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::EchoRequest).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :echo_request).to be_valid
	end

	it 'is not valid without txt' do
		expect(build :echo_request, echo_request: nil).to_not be_valid
	end
end