require 'spec_helper'

RSpec.describe Furs::Models::TaxesPerSeller do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::TaxesPerSeller).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :taxes_per_seller).to be_valid
	end

	it 'is not valid if seller_tax_number does not have 8 characters' do
		expect(build :taxes_per_seller, seller_tax_number: 1234567).not_to be_valid
		expect(build :taxes_per_seller, seller_tax_number: 123456789).not_to be_valid
	end

	it 'is not valid if one of the elements of v_a_t is valid' do
		invalid_v_a_t = build(:v_a_t, tax_rate: nil)
		expect(build :taxes_per_seller, v_a_t: [invalid_v_a_t]).not_to be_valid
	end

	it 'is not valid if taxes_per_seller is not an array with at least one element' do
		expect(build :taxes_per_seller, v_a_t: build(:v_a_t)).not_to be_valid
		expect(build :taxes_per_seller, v_a_t: []).not_to be_valid
		expect(build :taxes_per_seller, v_a_t: '123').not_to be_valid
	end

	it 'is not valid if one of the elements of flat_rate_compensation is not valid' do
		invalid_flat_rate_compensation = build(:flat_rate_compensation, flat_rate_rate: nil)
		expect(build :taxes_per_seller, flat_rate_compensation: [invalid_flat_rate_compensation]).not_to be_valid
	end

	it 'is not valid if taxes_per_seller is not an array with at least one element' do
		expect(build :taxes_per_seller, flat_rate_compensation: build(:flat_rate_compensation)).not_to be_valid
		expect(build :taxes_per_seller, flat_rate_compensation: []).not_to be_valid
		expect(build :taxes_per_seller, flat_rate_compensation: '123').not_to be_valid
	end

	[:other_taxes_amount, :exempt_v_a_t_taxable_amount, :reverse_v_a_t_taxable_amount, :non_taxable_amount, :special_tax_rules_amount].each do |attr|
		it "is not valid if #{attr} has more than 2 decimal places" do
			expect(build :taxes_per_seller, attr => 123.123).not_to be_valid
		end

		it "is not valid if #{attr} is less than 1000000000000" do
			expect(build :taxes_per_seller, attr => 1000000000000).not_to be_valid
		end
	end
end