module Furs
	module Models
		class Header < Furs::Models::BaseRequest
			extend Furs::Models::InitializableFromHash

			attr_accessor :message_i_d, :date_time

			validates :message_i_d, presence: true, format: Furs::Constant::UUID_REGEX
			validates :date_time, presence: true, format: Furs::Constant::DATE_TIME_REGEX

			def initialize
				@message_i_d = SecureRandom.uuid
				@date_time = Time.now.strftime("%Y-%m-%dT%H:%M:%S")
			end
		end
	end
end