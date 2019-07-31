require 'spec_helper'

RSpec.describe Furs::Models::VAT do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::VAT).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :v_a_t).to be_valid
	end

	[[:tax_rate, 1000], [:taxable_amount, 1000000000000], [:tax_amount, 1000000000000]].each do |(key,limit)|
		it "is not valid if #{key} is blank" do
			expect(build :v_a_t, key => nil).not_to be_valid
		end

		it "is not valid if #{key} has more than two decimals" do
			expect(build :v_a_t, key => 123.123).not_to be_valid
		end

		it "is not valid if #{key} is greater or equal than #{limit}" do
			expect(build :v_a_t, key => limit).not_to be_valid
		end
	end
end