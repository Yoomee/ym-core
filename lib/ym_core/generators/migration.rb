module YmCore::Generators
  
  module Migration
  
    def self.included(base)
      base.send(:include, Rails::Generators::Migration)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
    
      def next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end
    
    end
  
    private
    def try_migration_template(source, destination)
      begin
        migration_template source, destination
      rescue Rails::Generators::Error => e
        puts e
      end
    end
    
  end
  
end