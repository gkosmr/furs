module Furs
	module Models
		class FlatRateCompensation < Furs::Models::BaseRequest

			attr_accessor :flat_rate_rate, :flat_rate_taxable_amount, :flat_rate_amount

			validates :flat_rate_rate, presence: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000 }
			validates :flat_rate_taxable_amount, :flat_rate_amount, presence: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000 }

			def initialize

			end

		end
	end
end