require 'spec_helper'

RSpec.describe Furs::Models::ReferenceSalesBook do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::ReferenceSalesBook).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :reference_sales_book).to be_valid
	end

	it 'is not valid if reference_sales_book_identifier is not valid' do
		invalid_reference_sales_book_identifier = build(:reference_sales_book_identifier, invoice_number: nil)
		expect(build :reference_sales_book, reference_sales_book_identifier: invalid_reference_sales_book_identifier).not_to be_valid
	end

	it 'is not valid if reference_sales_book_issue_date is not in the right format' do
		expect(build :reference_sales_book, reference_sales_book_issue_date: "2019/08/10").not_to be_valid
	end	
end