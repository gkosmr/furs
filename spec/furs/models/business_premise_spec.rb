require 'spec_helper'

RSpec.describe Furs::Models::BusinessPremise do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::BusinessPremise).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all attributes are valid' do
		expect(build :business_premise).to be_valid
	end

	it 'has tax_number set to the one in config' do
		expect(build(:business_premise).tax_number).to eq(Furs.config.tax_number.to_i)
	end

	it 'is raises error if trying to set tax_number' do
		expect{build :business_premise, tax_number: 87654321}.to raise_error(NoMethodError)
	end

	it 'is not valid if tax_number is not an integer of length 8' do
		old = Furs.config.tax_number

		Furs.configure{ |config| config.tax_number = 1234567 }
		expect(build :business_premise).not_to be_valid
		
		Furs.configure{ |config| config.tax_number = 123456789 }
		expect(build :business_premise).not_to be_valid

		Furs.configure{ |config| config.tax_number = 'x2345678' }
		expect(build :business_premise).not_to be_valid

		Furs.configure{ |config| config.tax_number = old }
	end

	it 'is not valid if business_premise_i_d is blank' do
		expect(build :business_premise, business_premise_i_d: nil).not_to be_valid
	end

	it 'is not valid if business_premise_i_d is contains non-alphanumeric characters' do
		expect(build :business_premise, business_premise_i_d: '#123asda').not_to be_valid
	end

	it 'is not valid if business_premise_i_d is longer than 20 characters' do
		expect(build :business_premise, business_premise_i_d: 't3St'*6).not_to be_valid
	end

	it 'is not valid if b_p_identifier is blank' do
		expect(build :business_premise, b_p_identifier: nil).not_to be_valid
	end

	it 'is not valid if b_p_identifier is not valid?' do
		expect(build :business_premise, b_p_identifier: build(:b_p_identifier, real_estate_b_p: nil)).not_to be_valid
	end

	it 'is not valid if validity_date is blank' do
		expect(build :business_premise, validity_date: nil).not_to be_valid
	end

	it 'is not valid if validity_date is in the wrong format' do
		expect(build :business_premise, validity_date: '2020-1-03').not_to be_valid
	end

	it 'is not valid if closing_tag is not blank and not Z' do
		expect(build :business_premise, closing_tag: 'X').not_to be_valid
	end

	it 'is not valid if special_notes is not blank and longer than 100 characters' do
		expect(build :business_premise, special_notes: 'abdef'*21).not_to be_valid
	end

	it 'is not valid if software_supplier is blank' do
		expect(build :business_premise, software_supplier: nil).not_to be_valid
	end

	it 'is not valid if software_supplier is an empty array' do
		expect(build :business_premise, software_supplier: []).not_to be_valid
	end

	it 'is not valid if software_supplier is not an array' do
		expect(build :business_premise, software_supplier: 123).not_to be_valid
		expect(build :business_premise, software_supplier: 'asdsadasdas').not_to be_valid
		expect(build :business_premise, software_supplier: true).not_to be_valid
	end

	it 'is not valid if any element of software_supplier is not valid' do
		invalid_software_supplier = [build(:software_supplier, tax_number: 1234)]
		expect(build :business_premise, software_supplier: invalid_software_supplier).not_to be_valid
	end

	it 'it converts int_fields to int in json' do
		business_premise = build(:business_premise)
		data = business_premise.as_json
		expect(data['TaxNumber']).to be_a_kind_of(Integer)
	end
end