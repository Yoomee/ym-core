require 'uri'
require 'dragonfly'
begin
  require 'rack/cache'
rescue LoadError => e
  puts "Couldn't find rack-cache - make sure you have it in your Gemfile:"
  puts "  gem 'rack-cache', :require => 'rack/cache'"
  puts " or configure dragonfly manually instead of using 'dragonfly/rails/images'"
  raise e
end

### The dragonfly app ###
app = Dragonfly[:images]
app.configure_with(:rails)
app.configure_with(:imagemagick)
app.configure do |c|
  c.datastore.root_path = ::Rails.root.join('data/dragonfly', ::Rails.env).to_s
end

### Extend active record ###
if defined?(ActiveRecord::Base)
  app.define_macro(ActiveRecord::Base, :image_accessor)
  app.define_macro(ActiveRecord::Base, :file_accessor)
  
  class ActiveRecord::Base
    def default_image
      Dragonfly::App[:images].fetch(default_image_relative_path)
    end
    
    private
    def default_image_relative_path
      absolute_path = Dir.glob("#{Rails.root}/public/assets/dragonfly/defaults/#{self.class.to_s.underscore}-*").first.to_s
      absolute_path.sub(Regexp.new(Rails.root.to_s), '../../..')
    end
  end
end

### Insert the middleware ###
rack_cache_already_inserted = Rails.application.config.action_controller.perform_caching && Rails.application.config.action_dispatch.rack_cache

Rails.application.middleware.insert 0, Rack::Cache, {
  :verbose     => true,
  :metastore   => URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/meta"), # URI encoded in case of spaces
  :entitystore => URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/body")
} unless rack_cache_already_inserted

Rails.application.middleware.insert_after Rack::Cache, Dragonfly::Middleware, :images
