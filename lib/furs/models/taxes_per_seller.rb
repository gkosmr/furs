module Furs
	module Models
		class TaxesPerSeller < Furs::Models::BaseRequest

			attr_accessor :seller_tax_number, :v_a_t, :flat_rate_compensation, :other_taxes_amount, :exempt_v_a_t_taxable_amount, :reverse_v_a_t_taxable_amount, :non_taxable_amount, :special_tax_rules_amount

			validates :seller_tax_number, allow_blank: true, length: { is: 8 }
			validates :other_taxes_amount, :exempt_v_a_t_taxable_amount, :reverse_v_a_t_taxable_amount, :non_taxable_amount, :special_tax_rules_amount, allow_blank: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000 }
			validates :v_a_t, :flat_rate_compensation, allow_blank: nil, length: { minimum: 1 }
			validate do
				errors.add(:v_a_t, 'must be an array') unless v_a_t.nil? || v_a_t.is_a?(Array)
				errors.add(:flat_rate_compensation, 'must be an array') unless flat_rate_compensation.nil? || flat_rate_compensation.is_a?(Array)
			end

			def initialize
				@v_a_t = []	#Furs::Models::VAT.new
				@flat_rate_compensation = [] #Furs::Models::FlatRateCompensation.new
			end
		end
	end
end