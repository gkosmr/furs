require 'spec_helper'

RSpec.describe Furs::Models::BaseRequest do

	it 'includes ActiveModel::Validations module' do
		expect(Furs::Models::BaseRequest).to include(ActiveModel::Validations)
	end

	it 'raises exception if trying to set root' do
		expect{ build(:base_request).root = 'new root' }.to raise_error(NoMethodError)
	end

	[:as_json, :to_json, :valid?, :errors_hash, :empty?].each do |method|
		it "responds to #{method} method" do
			expect(build(:base_request)).to respond_to(method).with(0).arguments
		end
	end

	it '#as_json returns hash with not null properties and camelized keys' do
		bp = build :business_premise, business_premise_i_d: nil
		data = bp.as_json
		expect(data).to be_a_kind_of(Hash)
		expect(data).to have_key("SoftwareSupplier")
		expect(data["SoftwareSupplier"]).to be_kind_of(Array)
		expect(data).not_to have_key("BusinessPremiseID")
	end

	it '#as_json wraps it with root if not blank' do
		data = build(:invoice_request).as_json
		expect(data).to have_key('InvoiceRequest')
		expect(data.size).to be(1)
	end

	it '#to_json returns a valid JSON string' do
		json = build(:address, street: "This is my street").to_json
		expect(json).to be_a_kind_of(String)
		expect(JSON.parse(json)["Street"]).to eq('This is my street')
	end

	it '#valid? returns true if object and all its referenced objects are valid, and false otherwise' do
		expect(build(:invoice).valid?).to be(true)
		expect(build(:invoice, issue_date_time: nil).valid?).to be(false)
		expect(build(:invoice, invoice_identifier: build(:invoice_identifier, business_premise_i_d: nil)).valid?).to be(false)
	end

	it '#errors_hash return hash of all errors by fields' do 
		invoice = build :invoice, invoice_identifier: build(:invoice_identifier, business_premise_i_d: nil), issue_date_time: nil
		invoice.valid?
		hsh = invoice.errors_hash
		expect(hsh).to have_key(:issue_date_time)
		expect(hsh).to have_key(:invoice_identifier)
		expect(hsh.size).to be(2)
		expect(hsh[:invoice_identifier]).to have_key(:business_premise_i_d)
		expect(hsh[:invoice_identifier].size).to be(1)
	end

	it '#empty? if all instance variables are nil or empty' do 
		expect(build(:real_estate_b_p, property_i_d: build(:property_i_d, cadastral_number: nil, building_number: nil, building_section_number: nil), address: nil).empty?).to be(true)
		expect(build(:real_estate_b_p, property_i_d: build(:property_i_d, cadastral_number: 12, building_number: nil, building_section_number: nil), address: nil).empty?).to be(false)
	end

	
	it 'responds to class method initialize_from_hash' do
		expect(Furs::Models::BaseRequest).to respond_to(:initialize_from_hash).with(1).argument
	end
end