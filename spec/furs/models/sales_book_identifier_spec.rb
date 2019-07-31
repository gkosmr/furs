require 'spec_helper'

RSpec.describe Furs::Models::SalesBookIdentifier do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::SalesBookIdentifier).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :sales_book_identifier).to be_valid
	end

	it 'is not valid if invoice_number is blank' do
		expect(build :sales_book_identifier, invoice_number: nil).not_to be_valid
	end

	it 'is not valid if invoice_number is longer than 20 characters' do
		expect(build :sales_book_identifier, invoice_number: "a1$"*7).not_to be_valid
	end

	it 'is not valid if set_number is blank' do
		expect(build :sales_book_identifier, set_number: nil).not_to be_valid
	end

	it 'is not valid if set_number does not have two characters' do
		expect(build :sales_book_identifier, set_number: 'a').not_to be_valid
		expect(build :sales_book_identifier, set_number: 'a12').not_to be_valid
	end

	it 'is not valid if serial_number is blank' do
		expect(build :sales_book_identifier, serial_number: nil).not_to be_valid
	end

	it 'is not valid if serial_number does not have 12 characters' do
		expect(build :sales_book_identifier, serial_number: "abcefg12345").not_to be_valid
		expect(build :sales_book_identifier, serial_number: "abcefg1234567").not_to be_valid
	end
end