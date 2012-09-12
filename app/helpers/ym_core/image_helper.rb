module YmCore::ImageHelper

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
  end

  # TODO: get this working
  # def holding_image(geo_string, options = {})
  #   filename = File.dirname(__FILE__) + "/../../assets/images/holding.png"
  #   image_tag(Dragonfly[:images].fetch(filename).thumb(geo_string).url, options)
  # end

  def image_placeholder(geo_string, options = {})
    width, height = width_height_from_geo_string(geo_string)
    text_param = "&text=#{CGI.escape(options[:text])}" if options[:text].present?
    image_url = "http://placehold.it/#{[width,height].compact.join('x')}#{text_param}"
    options[:image_url] ? "" : image_tag(image_url, options)
  end

  def dragonfly_image_tag(*args)
    options = args.extract_options!
    image, geo_string = args[0], args[1]
    url = geo_string.blank? ? image.url : image.thumb(geo_string).url
    image_tag(url, options)
  end

  def image_for(*args)
    options = args.extract_options!
    object, geo_string = args[0], args[1]
    width, height = width_height_from_geo_string(geo_string)
    options.reverse_merge!(:alt => "#{(truncate(object.to_s || "", :length => (width || 50).to_i / 6))}")
    if object.image
      fetch_image_if_missing(object.image) if Rails.env.development?
      dragonfly_image_tag(object.image, geo_string, options)
    elsif object.default_image
      dragonfly_image_tag(object.default_image, geo_string, options)
    else
      options[:text] = options.delete(:placeholder_text)
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