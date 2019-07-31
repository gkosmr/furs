module Furs
	module Models
		class InvoiceResponse < Furs::Models::BaseResponse

			attr_accessor :header, :unique_invoice_i_d
		end
	end
end