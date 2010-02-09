require "generators/clearance"

module Clearance
  module Generators
    class ViewsGenerator < Base
      
      argument :name,     :type => :string, :required => false, :default => "erb"
      argument :strategy, :type => :string, :required => false, :default => "formtastic"
      
      def create_view_files
        users_path = File.join("app/views/users")
        empty_directory users_path
        copy_file "#{strategy}/users/new.html.#{name}", "app/views/users/new.html.#{name}"
        copy_file "#{strategy}/users/_inputs.html.#{name}", "app/views/users/_inputs.html.#{name}"

        sessions_path = File.join("app/views/sessions")
        empty_directory sessions_path
        copy_file "#{strategy}/sessions/new.html.#{name}", "app/views/sessions/new.html.#{name}"
                
        passwords_path = File.join("app/views/passwords")
        empty_directory passwords_path
        copy_file "#{strategy}/passwords/new.html.#{name}", "app/views/passwords/new.html.#{name}"
        copy_file "#{strategy}/passwords/edit.html.#{name}", "app/views/passwords/edit.html.#{name}"
      end
            
    end  
  end
end
