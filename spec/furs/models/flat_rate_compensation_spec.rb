require 'spec_helper'

RSpec.describe Furs::Models::FlatRateCompensation do

	it 'inherits from Furs::Models::BaseRequest' do
		expect(Furs::Models::FlatRateCompensation).to be < Furs::Models::BaseRequest
	end

	it 'is valid if all parameters are valid' do
		expect(build :flat_rate_compensation).to be_valid
	end

	[[:flat_rate_rate, 1000], [:flat_rate_taxable_amount, 1000000000000], [:flat_rate_amount, 1000000000000]].each do |(key,limit)|
		it "is not valid if #{key} is blank" do
			expect(build :flat_rate_compensation, key => nil).not_to be_valid
		end

		it "is not valid if #{key} has more than two decimals" do
			expect(build :flat_rate_compensation, key => 123.123).not_to be_valid
		end

		it "is not valid if #{key} is greater or equal than #{limit}" do
			expect(build :flat_rate_compensation, key => limit).not_to be_valid
		end
	end
end