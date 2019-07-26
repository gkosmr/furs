
ruby_project_files = Dir[File.join(File.dirname(__FILE__), '**', '*.rb')]

require 'furs/models/base_request'
ruby_project_files.sort_by!{ |file_name| file_name.downcase }.each do |path|
	require_relative path
end

module Furs
	extend Furs::Configurable

	[:echo, :register_business_premise, :issue_invoice].each do |name|
		Furs.define_singleton_method(name) do |data|
		  client.send(name, data)
		end
	end

	private
	
		def self.client
			@client ||= Furs::Client.new(Furs.config)
		end
end
