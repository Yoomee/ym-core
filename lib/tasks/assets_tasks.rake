namespace :assets do
  
  desc 'Recompile assets and commit to git'
  task :recompile do
    system("rm -rf ./public/assets")
    Rake::Task['assets:precompile'].execute
    system("git add public/assets")
    system("git commit -m 'Recompile assets' -- public/assets")
  end
  
end
