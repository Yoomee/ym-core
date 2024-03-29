module YmCore::GoogleApisHelper

  def google_analytics_js(options = {})
    if tracker_code = Settings.google_analytics.present?
      if (Rails.env == 'development' && options[:allow_dev]) || !!(Rails.env =~ /test|production/)
        options.reverse_merge!(:universal => true, :domain => Settings.site_url.sub(/(^https?:\/\/(www\.)?)?/, ''))
        pageview_override = session.delete(:ga_pageview_override).presence
        custom_pageview = session.delete(:ga_pageview).presence
        javascript_tag do
          if options[:universal]
            out = "(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

          ga('create', '#{tracker_code}', #{options[:allow_dev] ? "{'cookieDomain':'none'}" : "'#{options[:domain]}'"});
          #{options[:fields].collect{|field, value| "ga('set', '#{field}', String(#{value}));"}.join("\n") if options[:fields]}
          ga('send', 'pageview'#{", '#{pageview_override}'" if pageview_override});"
            out << "\n$(function(e) { ga('send', 'pageview', '#{custom_pageview}'); });" if custom_pageview
          else
            out = "var _gaq = _gaq || [];
          _gaq.push(['_setAccount', '#{tracker_code}']);
          #{"_gaq.push(['_setDomainName', '#{options[:allow_dev] ? 'none' : options[:domain]}']);" if options[:allow_dev] || options[:domain]}
          #{"_gaq.push(['_setAllowLinker', #{options[:allow_linker]}]);" if options[:allow_linker]}
          _gaq.push(['_trackPageview'#{", '#{pageview_override}'" if pageview_override}]);

          (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
          })();"
            out << "\n$(function(e) { _gaq.push(['_trackPageview', '#{custom_pageview}']); });" if custom_pageview
          end
          out.html_safe
        end
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
