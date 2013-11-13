window.Facebook =
  init: (appId) ->
    Facebook.AppId = appId
    FB.init({appId: Facebook.AppId, status: true, cookie: true})
  initPostToFeedLinks: () ->
    $('.main-wrapper').on 'click', 'a.share-facebook', (event) ->
      event.preventDefault()
      if $(this).data("ga-track-event").length
        GoogleAnalytics.trackEvent("social", "fb", $(this).data("ga-track-event"))
      Facebook.postToFeed(
        url: $(this).data('url')
        image: $(this).data('image-url')
        name: $(this).data('name')
        caption: $(this).data('caption')
        description: $(this).data('description')
      )
  postToFeed: (options) ->
    obj =
      method: 'feed'
      link: options.url
      picture: options.image
      name: options.name
      caption: options.caption
      description: options.description
    FB.ui(obj)
    
window.GoogleAnalytics =
  sendPageview: (pageview) ->
    if _gaq?
      _gaq.push(['_trackPageview', pageview])
    else if ga?
      ga('send', 'pageview', pageview)
  trackEvent: (category, action, label, value) ->
    if _gaq?
      _gaq.push(['_trackEvent', category, action, label, value])
    else if ga?
      ga('send', 'event', category, action, label, value)