require 'spec_helper'

RSpec.describe Furs::Models::BusinessPremiseRequest do

	it 'inherits from Furs::Models::BaseRequestWithHeader' do
		expect(Furs::Models::BusinessPremiseRequest).to be < Furs::Models::BaseRequestWithHeader
	end

	it 'is valid if all attributes valid' do
		expect(build :business_premise_request).to be_valid
	end

	it 'is not valid business premise is blank' do
		expect(build :business_premise_request, business_premise: nil).not_to be_valid
	end

	it 'is not valid if business premise is not valid' do
		expect(build :business_premise_request, business_premise: build(:business_premise, business_premise_i_d: nil)).not_to be_valid
	end
end