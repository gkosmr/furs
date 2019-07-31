require 'spec_helper'

RSpec.describe Furs::Models::RealEstateBP do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::RealEstateBP).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all attributes valid' do 
		expect(build :real_estate_b_p).to be_valid
	end

	it 'is not valid if property_i_d is blank' do 
		expect(build :real_estate_b_p, property_i_d: nil).not_to be_valid
	end

	it 'is not valid if address is blank' do 
		expect(build :real_estate_b_p, address: nil).not_to be_valid
	end

	it 'is not valid if property_i_d is not valid' do
		invalid_property_i_d = build(:property_i_d, building_number: nil)
		expect(build :real_estate_b_p, property_i_d: invalid_property_i_d).not_to be_valid
	end

	it 'is not valid if address is not valid' do
		invalid_address = build(:address, street: nil)
		expect(build :real_estate_b_p, address: invalid_address).not_to be_valid
	end
end