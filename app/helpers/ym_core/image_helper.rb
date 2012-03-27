module YmCore::ImageHelper

  class << self
    def download_image_url_prefix
      if @download_image_url_prefix.nil?
        prod_site_url = Settings.live_site_url
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
  end

  # TODO: get this working
  # def holding_image(geo_string, options = {})
  #   filename = File.dirname(__FILE__) + "/../../assets/images/holding.png"
  #   image_tag(Dragonfly[:images].fetch(filename).thumb(geo_string).url, options)
  # end

  def image_placeholder(geo_string, options = {})
    width, height = width_height_from_geo_string(geo_string)
    image_url = "http://placehold.it/#{[width,height].compact.join('x')}"
    options[:image_url] ? "" : image_tag(image_url, options)
  end

  def image_for(object, geo_string, options = {})
    width, height = width_height_from_geo_string(geo_string)
    options.reverse_merge!(:alt => "#{(object.to_s || "")[0..(width || 50).to_i / 6]}...")    
    if object.image
      fetch_image_if_missing(object.image) if Rails.env.development?
      image_tag(object.image.thumb(geo_string).url, options)
    elsif object.default_image
      image_tag(object.default_image.thumb(geo_string).url, options)
    else
      image_placeholder(geo_string, options)
    end
  end

  def width_height_from_geo_string(geo_string)
    res = geo_string.blank? ? nil : geo_string.match(/(\d+)x?(\d*)/)
    res ? [(res[1].blank? ? nil : res[1].to_i), (res[2].blank? ? nil : res[2].to_i)] : [nil, nil]
  end

  private
  def fetch_image_if_missing(image)
    begin
      image.path
    rescue Dragonfly::DataStorage::DataNotFound => e
      image_url = "#{YmCore::ImageHelper.download_image_url_prefix}#{image.url}"
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