module Furs
	module Models
		class BusinessPremise < Furs::Models::BaseRequest

			attr_accessor :business_premise_i_d, :b_p_identifier, :validity_date, :software_supplier, :special_notes, :closing_tag
			attr_reader :tax_number

			validates :tax_number, presence: true, length: { is: 8 }, numericality: { only_integer: true }
			validates :business_premise_i_d, presence: true, format: Furs::Constant::ALPHANUMERIC_REGEX, length: 1..20
			validates :b_p_identifier, presence: true
			validates :validity_date, presence: true, format: Furs::Constant::DATE_REGEX
			validates :closing_tag, allow_blank: true, inclusion: { in: %w(Z) }
			validates :special_notes, allow_blank: true, length: 1..100
			validates :software_supplier, presence: true, length: { minimum: 1 }
			validate do
				errors.add(:software_supplier, 'must be an array') unless software_supplier.is_a?(Array)
			end

			def initialize
				@tax_number = Furs.config.tax_number
				@b_p_identifier = Furs::Models::BPIdentifier.new
				@software_supplier = []
			end

			def int_fields
				%w(tax_number)
			end
		end
	end
end
