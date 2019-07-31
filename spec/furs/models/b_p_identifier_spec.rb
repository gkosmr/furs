require 'spec_helper'

RSpec.describe Furs::Models::BPIdentifier do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::BPIdentifier).to be < Furs::Models::BaseRequest
	end

	it 'is valid if only real_estate_b_p is not blank' do
		expect(build :immovable_b_p_identifier).to be_valid
	end

	it 'is valid if only premise_type is not blank' do
		expect(build :movable_b_p_identifier).to be_valid
	end

	it 'is not valid if both fields are nil' do
		expect(build :movable_b_p_identifier, premise_type: nil).not_to be_valid
	end

	it 'is not valid if both fields are not nil' do
		expect(build :immovable_b_p_identifier, premise_type: 'A').not_to be_valid
	end

	it 'is not valid if real_estate_b_p is not valid' do
		invalid_real_estate_b_p = build(:real_estate_b_p, address: nil)
		expect(build :immovable_b_p_identifier, real_estate_b_p: invalid_real_estate_b_p).not_to be_valid
	end
end