require "generators/clearance"

module Clearance
  module Generators
    class ClearanceGenerator < Base
      
      argument :name, :type => :string, :required => false, :default => "clearance"
      
      def update_application_controller
        sentinel = "class ApplicationController < ActionController::Base"
        inject_into_file "app/controllers/application_controller.rb", "include Clearance::Authentication", { :after => sentinel, :verbose => false }      
      end
      
      def create_or_update_user_model
        user_model = "app/models/user.rb"
        if File.exists?(user_model)
          sentinel = "class User < ActiveRecord::Base"
          inject_into_file user_model, "include Clearance::User",  { :after => sentinel, :verbose => false }
        else
          empty_directory File.join("app", "models")
          copy_file "user.rb", user_model
        end
      end
      
      def copy_factories      
        empty_directory File.join("test", "factories")  
        copy_file "factories.rb", "test/factories/clearance.rb"
      end
      
      def create_migration_file
        migration_template "migrations/#{migration_name}.rb", "db/migrate/#{@migration_number}clearance_#{migration_name}.rb"     
      end      
      
      def migration_name
        ActiveRecord::Base.connection.table_exists?(:users) ? 'update_users' : 'create_users'
      end
                  
    end  
  end
end
