module Furs
	module Models
		class SalesBookIdentifier < Furs::Models::BaseRequest

			attr_accessor :invoice_number, :set_number, :serial_number

			validates :invoice_number, presence: true, length: 1..20
			validates :set_number, presence: true, length: { is: 2 }
			validates :serial_number, presence: true, length: { is: 12 }

			def initialize inum = nil, stnum = nil, srnum = nil
				@invoice_number = inum
				@set_number = stnum
				@serial_number = srnum
			end
		end
	end
end