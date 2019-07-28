module Furs
	module Models
		class EchoRequest < Furs::Models::BaseRequest
			attr_accessor :echo_request

			validates :echo_request, presence: true

			def initialize txt = ""
				self.echo_request = txt
			end
		end
	end
end