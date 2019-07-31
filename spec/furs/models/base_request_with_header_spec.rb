require 'spec_helper'

RSpec.describe Furs::Models::BaseRequestWithHeader do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::BaseRequestWithHeader).to be < Furs::Models::BaseRequest
	end

	it 'raises exception if trying to set header' do
		expect{ build :base_request_with_header, header: nil }.to raise_error(NoMethodError)
	end
end



