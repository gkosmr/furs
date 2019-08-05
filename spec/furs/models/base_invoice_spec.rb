require 'spec_helper'

RSpec.describe Furs::Models::BaseInvoice do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::BaseInvoice).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :base_invoice).to be_valid
	end

	it 'is not valid if reference_invoice and reference_sales_book are both non-blank' do
		base_invoice = build :base_invoice, reference_sales_book: build(:reference_sales_book), reference_invoice: build(:reference_invoice)
		expect(base_invoice).not_to be_valid
	end

	it 'is not valid if customer_v_a_t_number is longer than 20 characters' do
		expect(build :base_invoice, customer_v_a_t_number: "123"*7).not_to be_valid
	end

	it 'is not valid if invoice_amount is blank' do
		expect(build :base_invoice, invoice_amount: nil).not_to be_valid
	end

	it 'is not valid if invoice_amount is more than 1000000000000' do
		expect(build :base_invoice, invoice_amount: 1000000000001).not_to be_valid
	end

	it 'is not valid if invoice_amount has more than two decimals' do
		expect(build :base_invoice, invoice_amount: 10.012).not_to be_valid
	end

	it 'is not valid if payment_amount is blank' do
		expect(build :base_invoice, payment_amount: nil).not_to be_valid
	end

	it 'is not valid if payment_amount is more than 1000000000000' do
		expect(build :base_invoice, payment_amount: 1000000000001).not_to be_valid
	end

	it 'is not valid if payment_amount has more than two decimals' do
		expect(build :base_invoice, payment_amount: 10.012).not_to be_valid
	end

	it 'is not valid if returns_amount is more than 1000000000000' do
		expect(build :base_invoice, returns_amount: 1000000000001).not_to be_valid
	end

	it 'is not valid if returns_amount has more than two decimals' do
		expect(build :base_invoice, returns_amount: 10.012).not_to be_valid
	end

	it 'is not valid if taxes_per_seller is blank' do
		expect(build :base_invoice, taxes_per_seller: nil).not_to be_valid
	end

	it 'is not valid if taxes_per_seller is not array with at least one element' do
		expect(build :base_invoice, taxes_per_seller: build(:taxes_per_seller)).not_to be_valid
		expect(build :base_invoice, taxes_per_seller: []).not_to be_valid
		expect(build :base_invoice, taxes_per_seller: '123').not_to be_valid
	end

	it 'is not valid if one of the elements is not valid' do
		expect(build :base_invoice, taxes_per_seller: [build(:taxes_per_seller, v_a_t: 1)]).not_to be_valid
	end

	it 'is not valid if reference_sales_book is not valid' do
		invalid_reference_sales_book = build(:reference_sales_book, reference_sales_book_issue_date: "2019")
		expect(build :base_invoice, reference_sales_book: invalid_reference_sales_book).not_to be_valid
	end

	it 'is not valid if reference_invoice is not valid' do
		invalid_reference_invoice = build(:reference_invoice, reference_invoice_issue_date_time: '2019')
		expect(build :base_invoice, reference_invoice: invalid_reference_invoice).not_to be_valid
	end

	it 'raises exception if trying to set header' do
		expect{ build(:base_invoice).tax_number = 12312312 }.to raise_error(NoMethodError)
	end

	it 'it converts int_fields to int in json' do
		base_invoice = build(:base_invoice)
		data = base_invoice.as_json
		expect(data['TaxNumber']).to be_a_kind_of(Integer)
	end

	it 'it converts decimal_fields to decimal in json' do
		base_invoice = build(:base_invoice, payment_amount: '123.12')
		data = base_invoice.as_json
		expect(data['PaymentAmount']).to be_a_kind_of(Float)
	end
end