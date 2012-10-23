class YmCore::ImageDownloader
  
  class << self
  
    def download_image_url_prefix
      if @download_image_url_prefix.nil?
        prod_site_url = Settings.live_site_url
        raise StandardError, "live_site_url is not set in config/settings.yml" if prod_site_url.blank?
        prod_site_url.chomp!("/")
        if Settings.http_basic && Settings.http_basic.enabled
          http_auth = [Settings.http_basic.username,Settings.http_basic.password].join(':')
          prod_site_url.sub!(%r{^http://}, "http://#{http_auth}@") if http_auth != ':'
        end
        @download_image_url_prefix = prod_site_url
      else
        @download_image_url_prefix
      end
    end
    
    def download_image_if_missing(image)
      begin
        image.path
      rescue Dragonfly::DataStorage::DataNotFound => e
        image_url = "#{download_image_url_prefix}#{image.url}"
        image_path = e.message.match(/\s([^\s]*)$/).try(:[],1)
        if !image_url.blank? && !image_path.blank?
          growl
          system("mkdir -p #{image_path.sub(/[^\/]*$/, "")}")
          puts "Downloading image: #{image_url}."
          system("curl -sf #{image_url} -o #{image_path}")
        end
      end
    end
  
    def growl
      if !@growled
        system("growlnotify -t 'Script/Server' -m 'Downloading missing image(s)'")
        @growled = true
      end
    end
    
  end  
end
