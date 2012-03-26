module YmCore::AnalyticsHelper
  
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
        })();"        
      end
    end
  end
  
end