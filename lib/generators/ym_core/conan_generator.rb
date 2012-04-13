module YmCore
  
  module Generators

    class ConanGenerator < Rails::Generators::Base
    
      source_root File.expand_path("../templates", __FILE__)
      desc "Create a new Conan App"

      def manifest
        copy_file "lib/ym_gem_loader.rb", "lib/ym_gem_loader.rb"
        copy_file "Gemfile.template", "Gemfile"
        copy_file "Gemfile.ym.template", "Gemfile.ym"
      end

    end

  end
  
end