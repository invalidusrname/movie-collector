require "generators/clearance"

module Clearance
  module Generators
    class FeaturesGenerator < Base
      
      argument :name,     :type => :string, :required => false, :default => "features"
      
      def copy_files
        features_path = File.join("features")
        steps_path = File.join("features/step_definitions")
        support_path = File.join("features/support")
        
        [features_path, steps_path, support_path].each do |dir|
          empty_directory dir
        end
        
        ["features/step_definitions/clearance_steps.rb",
         "features/step_definitions/factory_girl_steps.rb",
         "features/support/paths.rb",
         "features/sign_in.feature",
         "features/sign_out.feature",
         "features/sign_up.feature",
         "features/password_reset.feature"].each do |file|
           copy_file file, file
         end
                 
      end
            
    end  
  end
end
