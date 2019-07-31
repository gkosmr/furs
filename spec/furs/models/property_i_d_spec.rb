require 'spec_helper'

RSpec.describe Furs::Models::PropertyID do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::PropertyID).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all attributes valid' do 
		expect(build :property_i_d).to be_valid
	end

	it 'is not valid if cadastral_number is blank' do 
		expect(build :property_i_d, cadastral_number: nil).not_to be_valid
	end

	it 'is not valid if cadastral_number is not an integer' do 
		expect(build :property_i_d, cadastral_number: 'xxx').not_to be_valid
		expect(build :property_i_d, cadastral_number: 5.1).not_to be_valid
	end

	it 'is not valid if cadastral_number is less or equal than 0' do 
		expect(build :property_i_d, cadastral_number: 0).not_to be_valid
	end

	it 'is not valid if cadastral_number is greater or equal than 10000' do 
		expect(build :property_i_d, cadastral_number: 10000).not_to be_valid
	end

	it 'is not valid if building_number is blank' do 
		expect(build :property_i_d, building_number: nil).not_to be_valid
	end

	it 'is not valid if building_number is not an integer' do 
		expect(build :property_i_d, building_number: 'xxx').not_to be_valid
		expect(build :property_i_d, building_number: 5.1).not_to be_valid
	end

	it 'is not valid if building_number is less or equal than 0' do 
		expect(build :property_i_d, building_number: 0).not_to be_valid
	end

	it 'is not valid if building_number is greater or equal than 100000' do 
		expect(build :property_i_d, building_number: 100000).not_to be_valid
	end

	it 'is not valid if building_section_number is blank' do 
		expect(build :property_i_d, building_section_number: nil).not_to be_valid
	end

	it 'is not valid if building_section_number is not an integer' do 
		expect(build :property_i_d, building_section_number: 'xxx').not_to be_valid
		expect(build :property_i_d, building_section_number: 5.1).not_to be_valid
	end

	it 'is not valid if building_section_number is less or equal than 0' do 
		expect(build :property_i_d, building_section_number: 0).not_to be_valid
	end

	it 'is not valid if building_section_number is greater or equal than 10000' do 
		expect(build :property_i_d, building_section_number: 10000).not_to be_valid
	end
end