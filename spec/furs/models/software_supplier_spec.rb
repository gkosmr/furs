require 'spec_helper'

RSpec.describe Furs::Models::SoftwareSupplier do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::SoftwareSupplier).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all attributes valid' do 
		expect(build :domestic_software_supplier).to be_valid
		expect(build :foreign_software_supplier).to be_valid
	end

	it 'is not valid if both properties are blank' do 
		expect(build :domestic_software_supplier, tax_number: nil).not_to be_valid
	end

	it 'is not valid if both properties are not blank' do 
		expect(build :domestic_software_supplier, name_foreign: 'test company').not_to be_valid
	end

	it 'is not valid if tax_number has more or less than 8 characters' do 
		expect(build :domestic_software_supplier, tax_number: 123456789).not_to be_valid
		expect(build :domestic_software_supplier, tax_number: 1234567).not_to be_valid
	end

	it 'is not valid if name_foreign has more than 1000 characters' do 
		expect(build :foreign_software_supplier, name_foreign: 'a'*1001).not_to be_valid
	end

	it 'it converts int_fields to int in json' do
		domestic_software_supplier = build(:domestic_software_supplier, tax_number: '12312312')
		data = domestic_software_supplier.as_json
		expect(data['TaxNumber']).to be_a_kind_of(Integer)
	end
end