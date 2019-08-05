require "active_support/core_ext/string"
require "active_model"
require 'json'

module Furs
	module Models
		class BaseRequest
			include ActiveModel::Validations
			extend Furs::Models::InitializableFromHash

			attr_reader :root

			def as_json
	            data = self.instance_variables.inject({}) do |hsh, attribute| 
	            	key = attribute.to_s.gsub('@','').camelize
	            	tmp = self.instance_variable_get(attribute)
	            	if tmp.is_a?(Array) && !tmp.empty?
	            		hsh.merge( key => tmp.map{ |el| to_val(el) } )
	            	else
		            	val = to_val(tmp)
		            	val.blank? || %w(Root Errors).include?(key) || ( val.is_a?(Array) && val.length == 0 ) || ( tmp.class < Furs::Models::BaseRequest && tmp.empty? ) ? hsh : hsh.merge( key => val )
	            	end
	            end

	            root.nil? ? data : { root => data }
            end
		
		    def to_json
		        as_json.to_json
		    end

		    def valid?
		    	base_valid = super
		    	objects_valid = base_request_objects.all?{ |_, val| val.nil? || val.valid? }
		    	arrays_valid = arrays.all?{ |_,arr| arr.compact.all?(&:valid?) }
		    	base_valid && objects_valid && arrays_valid
		    end

		    def errors_hash
		    	hsh = errors.messages
		    	base_request_objects.each do |field, val|
		    		msgs = val.errors.messages
		    		hsh[field.to_sym] = msgs unless msgs.empty?
		    	end
		    	hsh
		    end

		    def empty?
		    	self.instance_variables.all? do |attribute| 
		    		val = self.instance_variable_get(attribute)
		    		val.blank? || ( val.kind_of?(Array) && val.empty? ) || ( val.class < Furs::Models::BaseRequest && val.empty? )
		    	end
		    end

		    private

		    	def to_val tmp
		    		tmp.class < Furs::Models::BaseRequest ? tmp.as_json : tmp
		    	end

		    	def base_request_objects
		    		self.instance_variables.map{ |attribute| [attribute.to_s.gsub('@', ''), self.instance_variable_get(attribute)] }.select{ |_,val| val.class < Furs::Models::BaseRequest }.to_h
		    	end

		    	def arrays
		    		self.instance_variables.map{ |attribute| [attribute.to_s.gsub('@', ''), self.instance_variable_get(attribute)] }.select{ |_,val| val.kind_of?(Array) }.to_h
		    	end
	    end
	end
end