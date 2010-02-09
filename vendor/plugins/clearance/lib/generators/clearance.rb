require 'rails/generators/named_base'

module Clearance
  module Generators
    class Base < Rails::Generators::NamedBase  #:nodoc:
      
      def self.source_root
        @_clearance_source_root ||= 
          File.expand_path("../#{generator_name}/templates", __FILE__)
      end
      
    end
  end
end  