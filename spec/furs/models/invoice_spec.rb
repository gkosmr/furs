require 'spec_helper'

RSpec.describe Furs::Models::Invoice do

	it 'inherits from Furs::Models::BaseInvoice' do
		expect(Furs::Models::Invoice).to be < Furs::Models::BaseInvoice
	end

	it 'is valid if all parameters are valid' do
		expect(build :invoice).to be_valid
	end

	it 'is not valid if issue_date_time is blank' do
		expect(build :invoice, issue_date_time: nil).not_to be_valid
	end

	it 'is not valid if issue_date_time is not in the right format' do
		expect(build :invoice, issue_date_time: "2019-07-30").not_to be_valid
	end

	it 'is not valid if numbering_structure is blank' do
		expect(build :invoice, numbering_structure: nil).not_to be_valid
	end

	it 'is not valid if numbering_structure is not B or C' do
		expect(build :invoice, numbering_structure: 'A').not_to be_valid
	end

	it 'is not valid if invoice_identifier is blank' do
		expect(build :invoice, invoice_identifier: nil).not_to be_valid
	end

	it 'is not valid if invoice_identifier is not valid' do
		invalid_invoice_identifier = build(:invoice_identifier, business_premise_i_d: nil)
		expect(build :invoice, invoice_identifier: invalid_invoice_identifier).not_to be_valid
	end

	it 'is not valid if invoice_identifier is blank' do
		expect(build :invoice, invoice_identifier: nil).not_to be_valid
	end

	it 'is not valid if operator_tax_number is not 8 characters long' do
		expect(build :invoice, operator_tax_number: 123456789).not_to be_valid
		expect(build :invoice, operator_tax_number: 1234567).not_to be_valid
	end

	it 'is not valid if foreign_operator is not bool' do
		expect(build :invoice, foreign_operator: 123).not_to be_valid
		expect(build :invoice, foreign_operator: 'test').not_to be_valid
	end

	it 'is not valid if subsequent_submit is not bool' do
		expect(build :invoice, subsequent_submit: 123).not_to be_valid
		expect(build :invoice, subsequent_submit: 'test').not_to be_valid
	end

	it 'is not valid if protected_i_d is blank' do
		expect(build :invoice, protected_i_d: nil).not_to be_valid
	end

	it 'is not valid if protected_i_d is not 32 characters long' do
		expect(build :invoice, protected_i_d: "1"*31).not_to be_valid
		expect(build :invoice, protected_i_d: "a1f"*11).not_to be_valid
	end

	it 'is not valid if protected_i_d contains invalid non-hexadecimal characters' do
		id = "a16f3eb4c290d758"
		expect(build :invoice, protected_i_d: id + 'A').not_to be_valid
		expect(build :invoice, protected_i_d: id + '$').not_to be_valid
		expect(build :invoice, protected_i_d: id + 'x').not_to be_valid
	end

	it 'it converts int_fields to int in json' do
		invoice = build(:invoice, operator_tax_number: '12312312')
		data = invoice.as_json
		expect(data['OperatorTaxNumber']).to eq(12312312)
	end

	it 'responds to generate_zoi! method' do
		expect(build(:invoice)).to respond_to(:generate_zoi!).with(0).arguments
	end

end