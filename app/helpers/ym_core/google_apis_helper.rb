module YmCore::GoogleApisHelper
  
  def google_analytics_js
    if !(Rails.env =~ /development|test/) && (tracker_code = Settings.google_analytics).present?
      javascript_tag do
        "var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '#{tracker_code}']);
        _gaq.push(['_trackPageview']);

        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();".html_safe
      end
    end
  end
  
  def google_maps_javascript_include_tag
    unless @google_maps_javascript_included
      @google_maps_javascript_included = true
      content_for :head do
        javascript_include_tag("http://maps.googleapis.com/maps/api/js?key=AIzaSyAIXsdk6KMk2qhPu1iNsN3RNDiWdyT3fXY&sensor=false")
      end
    end
  end
  
end