module Furs
	module Models
		class BusinessPremise < Furs::Models::BaseRequest

			attr_accessor :tax_number, :business_premise_i_d, :b_p_identifier, :validity_date, :software_supplier, :special_notes, :closing_tag

			validates :tax_number, presence: true, length: { is: 8 }
			validates :business_premise_i_d, presence: true, format: /\A[a-zA-Z0-9]{1,20}\z/
			validates :b_p_identifier, presence: true
			validates :validity_date, presence: true, format: /\A\d{4}\-[0-1]\d\-[0-3]\d\z/
			validates :closing_tag, allow_nil: true, inclusion: { in: %w(Z) }
			validates :special_notes, allow_nil: true, length: 1..100
			validates :software_supplier, presence: true, length: { minimum: 1 }

			def initialize
				@b_p_identifier = Furs::Models::BPIdentifier.new
				@software_supplier = []
			end

			# TODO
			def add_sofware_supplier sp
				software_supplier << sp
			end
		end
	end
end
