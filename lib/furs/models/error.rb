module Furs
	module Models
		class Error < Furs::Models::BaseResponse
			attr_accessor :error_code, :error_message
		end
	end
end