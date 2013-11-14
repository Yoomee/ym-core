window.Facebook =
  init: (appId) ->
    Facebook.AppId = appId
    FB.init({appId: Facebook.AppId, status: true, cookie: true})
  initPostToFeedLinks: () ->
    $('.main-wrapper').on 'click', 'a.share-facebook', (event) ->
      event.preventDefault()
      Facebook.postToFeed(
        url: $(this).data('url')
        image: $(this).data('image-url')
        name: $(this).data('name')
        caption: $(this).data('caption')
        description: $(this).data('description')
        ga_event: $(this).data("ga-event")
      )
  postToFeed: (options) ->
    obj =
      method: 'feed'
      link: options.url
      picture: options.image
      name: options.name
      caption: options.caption
      description: options.description
    FB.ui obj, (response) ->
      if response && options.ga_event?
        GoogleAnalytics.trackEvent('social', 'fb', options.ga_event)

window.Twitter =
  initShareLinks:() ->
    if $('a.share-twitter').length > 0
      $('.main-wrapper').on 'click', 'a.share-twitter', (event) ->
        event.preventDefault()
        GoogleAnalytics.trackEvent('social', 'tweet', $(this).data('ga-event'))
        PopUpFrame.open(this.href, 'Share a link on Twitter') 
    
window.PopUpFrame =
  open: (url, title) ->
    width = 550
    height = 470
    left = (screen.width / 2) - (width / 2)
    top = (screen.height / 2) - (height / 2)
    window.open(url, title, "toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{width}, height=#{height}, top=#{top}, left=#{left}")

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