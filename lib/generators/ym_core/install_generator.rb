module YmCore
  module Generators    
    class InstallGenerator < Rails::Generators::Base
      include YmCore::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      desc "Installs YmCore."

      def manifest
        copy_file "views/admin/index.html.haml", "app/views/admin/index.html.haml"
        # Migrations must go last
        Dir[File.dirname(__FILE__) + '/templates/migrations/*.rb'].each do |file_path|
          file_name = file_path.split("/").last
          try_migration_template "migrations/#{file_name}", "db/migrate/#{file_name.sub(/^\d+\_/, '')}"
        end
      end
      
    end
  end
end
