namespace :db do
  
  desc 'Dump database'
  task :dump do
    config = YAML.load(File.new(File.join(Rails.root, '/config/database.yml')))
    if config.keys.count == 1
      config = config[config.keys.first]
    else
      config = config[Rails.env]
    end
    db = config["database"]
    dump_path = "#{Rails.root}/db/#{db}.sql"
    puts "Dumping #{db} database to #{dump_path}"
    system("mysqldump -u#{config["username"]} -p#{config["password"]} #{db} > #{dump_path}")
    puts "Compressing #{db}.sql to #{db}.sql.tgz"
    system("cd #{Rails.root}/db && tar -czvf #{db}.sql.tgz #{db}.sql")
    puts "Complete"
  end
  
  desc "Migrate and prepare test database"
  task :migrate_full => [:migrate, "test:prepare"]
  
  desc "Migrate and prepare test database"
  task :full_migrate => :migrate_full  
  
end