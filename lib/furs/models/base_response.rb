module Furs
	module Models
		class BaseResponse
			extend Furs::Models::InitializableFromHash

			attr_accessor :error
		end
	end
end