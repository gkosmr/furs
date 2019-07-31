require 'spec_helper'

RSpec.describe Furs::Models::ReferenceInvoice do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::ReferenceInvoice).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :reference_invoice).to be_valid
	end

	it 'is not valid if reference_sales_book_identifier is not valid' do
		invalid_reference_invoice_identifier = build(:reference_invoice_identifier, business_premise_i_d: nil)
		expect(build :reference_invoice, reference_invoice_identifier: invalid_reference_invoice_identifier).not_to be_valid
	end

	it 'is not valid if reference_invoice_issue_date_time is not in the right format' do
		expect(build :reference_invoice, reference_invoice_issue_date_time: "2019/08/10T10:10:10").not_to be_valid
	end	
end