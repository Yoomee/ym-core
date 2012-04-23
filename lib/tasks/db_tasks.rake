namespace :db do
  
  desc 'Dump database'
  task :dump do
    #config = YAML.load(File.new(File.join(Rails.root, '/config/database.yml')))
    # if config.keys.count == 1
    #   config = config[config.keys.first]
    # else
    #   config = config[Rails.env]
    # end
    #db = config["database"]
    db = Rails.root.to_s.match(/\/data\/(\w+)\//)[1]
    dump_path = "#{Rails.root}/db/#{db}.sql"
    puts "Dumping #{db} database to #{dump_path}"
    system("mysqldump -uroot #{db} > #{dump_path}")
    puts "Compressing #{db}.sql to #{db}.sql.tgz"
    system("cd #{Rails.root}/db && tar -czvf #{db}.sql.tgz #{db}.sql")
    puts "Complete"
  end
  
  desc "Migrate and prepare test database"
  task :migrate_full => [:migrate, "test:prepare"]
  
  desc "Migrate and prepare test database"
  task :full_migrate => :migrate_full  
  
  namespace :migrate_full do
    
    desc "Redo the last migration and prepare test database"
    task :redo => ["migrate:redo", "test:prepare"]
      
  end
  
  desc "Find missing indexes"
  task :missing_indexes => :environment do
    puts "========================================" 
    puts "| Looking for possible missing indexes |"
    puts "========================================"
    tables = ActiveRecord::Base.connection.select_values('show tables')
    tables.each do |t|
      columns = ActiveRecord::Base.connection.select_values("describe #{t}")
      keys = columns.select{|k| k.match(/_(id|type)$/)}
      indexes = []
      ActiveRecord::Base.connection.execute("show indexes in #{t}").each {|i| indexes << i[4]}
      if (missing_indexes = keys - indexes).present?
        puts "#{t}\n  => #{missing_indexes.sort.join(', ')}"
      end
    end
  end
  
  
end