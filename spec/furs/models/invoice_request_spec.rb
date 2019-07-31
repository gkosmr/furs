require 'spec_helper'

RSpec.describe Furs::Models::InvoiceRequest do

	it 'inherits from Furs::Models::BaseRequestWithHeader' do
		expect(Furs::Models::InvoiceRequest).to be < Furs::Models::BaseRequestWithHeader
	end

	it 'is valid if all parameters are valid' do
		expect(build :invoice_request).to be_valid
		expect(build :sales_book_invoice_request).to be_valid
	end

	it 'is not valid if invoice is not valid' do
		invalid_invoice = build(:invoice, invoice_amount: nil)
		expect(build :invoice_request, invoice: invalid_invoice).not_to be_valid
	end

	it 'is not valid if sales_book_invoice is not valid' do
		invalid_sales_book_invoice = build(:sales_book_invoice, invoice_amount: nil)
		expect(build :sales_book_invoice_request, sales_book_invoice: invalid_sales_book_invoice).not_to be_valid
	end

	it 'is not valid if both fields are blank' do
		expect(build :invoice_request, invoice: nil).not_to be_valid
	end

	it 'is not valid if both fields are non-blank' do
		expect(build :invoice_request, sales_book_invoice: build(:sales_book_invoice)).not_to be_valid
	end
end