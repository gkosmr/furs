module Furs
	module Models
		class BPIdentifier < Furs::Models::BaseRequest

			attr_accessor :real_estate_b_p, :premise_type

			validates :premise_type, allow_blank: true, inclusion: { in: %w(A B C) }
			validate do
				errors.add(:base, 'Only one of the fields can be blank') if ((real_estate_b_p.nil? || real_estate_b_p.empty?) && premise_type.nil?) || (!(real_estate_b_p.nil? || real_estate_b_p.empty?) && !premise_type.nil?)
			end

			def initialize
				@real_estate_b_p = Furs::Models::RealEstateBP.new
			end
		end
	end
end