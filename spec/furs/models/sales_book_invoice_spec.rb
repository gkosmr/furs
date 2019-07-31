require 'spec_helper'

RSpec.describe Furs::Models::SalesBookInvoice do

	it 'inherits from Furs::Models::BaseInvoice' do
		expect(Furs::Models::SalesBookInvoice).to be < Furs::Models::BaseInvoice
	end

	it 'is valid if all parameters are valid' do
		expect(build :sales_book_invoice).to be_valid
	end

	it 'is not valid if issue_date is blank' do
		expect(build :sales_book_invoice, issue_date: nil).not_to be_valid
	end

	it 'is not valid if issue_date is in the wrong format' do
		expect(build :sales_book_invoice, issue_date: "2019/07/21").not_to be_valid
	end

	it 'is not valid if sales_book_identifier is blank' do
		expect(build :sales_book_invoice, sales_book_identifier: nil).not_to be_valid
	end

	it 'is not valid if sales_book_identifier is not valid?' do
		invalid_sales_book_identifier = build(:sales_book_identifier, invoice_number: nil)
		expect(build :sales_book_invoice, sales_book_identifier: invalid_sales_book_identifier).not_to be_valid
	end

	it 'is not valid if business_premise_i_d is blank' do
		expect(build :sales_book_invoice, business_premise_i_d: nil).not_to be_valid
	end

	it 'is not valid if business_premise_i_d is longer 20 characters' do
		expect(build :sales_book_invoice, business_premise_i_d: "a1C"*7).not_to be_valid
	end

	it 'is not valid if business_premise_i_d contains non-alphanumeric characters' do
		expect(build :sales_book_invoice, business_premise_i_d: "test#").not_to be_valid
		expect(build :sales_book_invoice, business_premise_i_d: "test}").not_to be_valid
		expect(build :sales_book_invoice, business_premise_i_d: "test,").not_to be_valid
	end
end