require 'spec_helper'

RSpec.describe Furs::Models::Address do

	before :each do
		@address = build(:address)
	end

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::Address).to be < Furs::Models::BaseRequest
	end

	it 'is valid with all parameters' do
		expect(@address).to be_valid
	end

	it 'is not valid without street' do
		@address.street = nil
		expect(@address).to_not be_valid
	end

	it 'is not valid if street is longer than 100 characters' do
		@address.street = "test"*26
		expect(@address).to_not be_valid
	end

	it 'is not valid without community' do
		@address.community = nil
		expect(@address).to_not be_valid
	end

	it 'is not valid if community is longer than 100 characters' do
		@address.community = "test"*26
		expect(@address).to_not be_valid
	end

	it 'is not valid without house_number' do
		@address.house_number = nil
		expect(@address).to_not be_valid
	end

	it 'is not valid if house_number is longer than 10 characters' do
		@address.house_number = "2"*11
		expect(@address).to_not be_valid
	end

	it 'is not valid if house_number_additional is longer than 10 characters' do
		@address.house_number_additional = "2"*11
		expect(@address).to_not be_valid
	end

	it 'is not valid without city' do
		@address.city = nil
		expect(@address).to_not be_valid
	end

	it 'is not valid if city is longer than 40 characters' do
		@address.city = "test"*11
		expect(@address).to_not be_valid
	end

	it 'is not valid without postal_code' do
		@address.postal_code = nil
		expect(@address).to_not be_valid
	end

	it 'is not valid if postal_code length is not 4 characters' do
		@address.postal_code = "11111"
		expect(@address).to_not be_valid

		@address.postal_code = "222"
		expect(@address).to_not be_valid
	end
end