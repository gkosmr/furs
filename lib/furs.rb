ruby_project_files = Dir[File.join(File.dirname(__FILE__), '**', '*.rb')]

require 'furs/models/initializable_from_hash'
require 'furs/models/base_request'
require 'furs/models/base_response'
require 'furs/models/sales_book_identifier'
ruby_project_files.sort_by!{ |file_name| file_name.downcase }.each do |path|
	require_relative path unless path.end_with?('furs/models/base_request')
end

module Furs
	extend Furs::Configurable

	[:echo, :register_business_premise, :issue_invoice].each do |name|
		Furs.define_singleton_method(name) do |data|
		  client.send(name, data)
		end
	end

	def self.p12
		@p12 ||= OpenSSL::PKCS12.new File.read(config.certificate_path), config.certificate_password
	end

	private
	
		def self.client
			return @client unless @client.nil?

			fail(Exceptions::InvalidConfiguration, 'Configuration is invalid. All properties must be set.') unless is_config_valid?

			@client = Furs::Client.new(Furs.config)
			@client
		end

		def self.is_config_valid?
			Furs.config.instance_variables.none?{ |attr| Furs.config.instance_variable_get(attr).nil? }
		end
end
