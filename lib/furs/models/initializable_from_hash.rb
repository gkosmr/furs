module Furs
	module Models
		module InitializableFromHash

			def initialize_from_hash data
				obj = self.new
				data.each do |key, val|
					field = key.underscore(false)
					if val.kind_of?(Array)
						model = "Furs::Models::#{key}".constantize
						value = val.map{ |x| model.initialize_from_hash x }
					elsif val.kind_of?(Hash)
						model = "Furs::Models::#{key}".constantize
						value = model.initialize_from_hash val
					else
						value = val
					end
					obj.instance_variable_set "@#{field}", value
				end
				obj
			end

		end
	end
end