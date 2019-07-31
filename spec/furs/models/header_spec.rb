require 'spec_helper'

RSpec.describe Furs::Models::Header do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::Header).to be < Furs::Models::BaseRequest
	end

	it 'is valid' do
		expect(build :header).to be_valid
	end

	it 'responds to class method initialize_from_hash' do
		expect(Furs::Models::Header).to respond_to(:initialize_from_hash).with(1).argument
	end
end