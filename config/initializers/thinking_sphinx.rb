if Rails.env.development? && File.basename($0) != "rake" && defined? ThinkingSphinx
  if Dir["#{Rails.root}/db/sphinx/development/*"].empty?
    puts "=> Running rake ts:rebuild"
    system("bundle exec rake thinking_sphinx:rebuild")
  elsif !ThinkingSphinx.sphinx_running?
    puts "=> Starting Thinking Sphinx"
    system("bundle exec rake thinking_sphinx:start")
  end
end