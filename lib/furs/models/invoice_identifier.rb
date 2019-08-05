module Furs
	module Models
		class InvoiceIdentifier < Furs::Models::BaseRequest

			attr_accessor :business_premise_i_d, :electronic_device_i_d, :invoice_number

			validates :business_premise_i_d, :electronic_device_i_d, presence: true, format: Furs::Constant::ALPHANUMERIC_REGEX, length: 1..20
			validates :invoice_number, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 100000000000000000000 }

			def initialize bpid = nil, edid = nil, inum = nil
				@business_premise_i_d = bpid
				@electronic_device_i_d = edid
				@invoice_number = inum
			end
		end
	end
end