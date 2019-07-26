module Furs
	module Models
		class Header < Furs::Models::BaseRequest

			attr_reader :message_i_d, :date_time

			validates :message_i_d, presence: true, format: /\A[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}\z/
			validates :date_time, presence: true, format: /\A\d{4}\-[0-1]\d\-[0-3]\dT[0-2]\d\:[0-5]\d\:[0-5]\d\z/

			def initialize
				@message_i_d = SecureRandom.uuid
				@date_time = Time.now.strftime("%Y-%m-%dT%H:%M:%S")
			end
		end
	end
end