module YmCore::SettingsHelper
  
  def site_host
    Settings.site_url.gsub(/^https?:\/\//, '')
  end
  
end