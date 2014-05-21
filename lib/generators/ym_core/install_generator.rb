module YmCore
  module Generators    
    class InstallGenerator < Rails::Generators::Base
      include YmCore::Generators::Migration
      
      source_root File.expand_path("../templates", __FILE__)
      desc "Installs YmCore."

      def manifest
        copy_file "views/admin/index.html.haml", "app/views/admin/index.html.haml"
        # Migrations must go last
        try_migration_template "migrations/create_redactor_uploads.rb", "db/migrate/create_redactor_uploads.rb"
      end
      
    end
  end
end
