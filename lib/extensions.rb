# frozen_string_literal: true

require "active_support/inflections"
require "active_support/core_ext/regexp"

module ActiveSupport
  module Inflector
    extend self

    def underscore(camel_cased_word, use_acronyms = true)
      return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)
      word = camel_cased_word.to_s.gsub("::".freeze, "/".freeze)
      if use_acronyms
        word.gsub!(inflections.acronyms_underscore_regex) { "#{$1 && '_'.freeze }#{$2.downcase}" }
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
      else
        word.gsub!(/([A-Z])/, '_\1')
        word.delete_prefix!('_')
      end
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
      word.tr!("-".freeze, "_".freeze)
      word.downcase!
      word
    end
  end
end

class String
  def underscore use_acronyms = true
    ActiveSupport::Inflector.underscore(self, use_acronyms)
  end  
end