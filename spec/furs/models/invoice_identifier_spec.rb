require 'spec_helper'

RSpec.describe Furs::Models::InvoiceIdentifier do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::InvoiceIdentifier).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :invoice_identifier).to be_valid
	end

	it 'is not valid if business_premise_i_d is blank' do
		expect(build :invoice_identifier, business_premise_i_d: nil).not_to be_valid
	end

	it 'is not valid if business_premise_i_d is more than 20 characters long' do
		expect(build :invoice_identifier, business_premise_i_d: 'xyz'*7).not_to be_valid
	end

	it 'is not valid if business_premise_i_d contains non-alphanumeric characters' do
		expect(build :invoice_identifier, business_premise_i_d: 'test#').not_to be_valid
		expect(build :invoice_identifier, business_premise_i_d: 'testŽ').not_to be_valid
		expect(build :invoice_identifier, business_premise_i_d: 'test,').not_to be_valid
	end

	it 'is not valid if electronic_device_i_d is blank' do
		expect(build :invoice_identifier, electronic_device_i_d: nil).not_to be_valid
	end

	it 'is not valid if electronic_device_i_d is more than 20 characters long' do
		expect(build :invoice_identifier, electronic_device_i_d: 'xyz'*7).not_to be_valid
	end

	it 'is not valid if electronic_device_i_d contains non-alphanumeric characters' do
		expect(build :invoice_identifier, electronic_device_i_d: 'test#').not_to be_valid
		expect(build :invoice_identifier, electronic_device_i_d: 'testŽ').not_to be_valid
		expect(build :invoice_identifier, electronic_device_i_d: 'test,').not_to be_valid
	end

	it 'is not valid if invoice_number is blank' do
		expect(build :invoice_identifier, invoice_number: nil).not_to be_valid
	end

	it 'is not valid if invoice_number is less or equal than 0' do
		expect(build :invoice_identifier, invoice_number: -1).not_to be_valid
	end

	it 'is not valid if invoice_number is greater or equal than 100000000000000000000' do
		expect(build :invoice_identifier, invoice_number: 100000000000000000000).not_to be_valid
	end

	it 'is not valid if invoice_number is decimal' do
		expect(build :invoice_identifier, invoice_number: 10.5).not_to be_valid
	end
end