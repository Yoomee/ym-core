#= require bootstrap
#= require jquery-migrate
#= require jquery.ui.all
#= require jquery-ui-timepicker-addon

window.YmCore =
  addDefaults: (options, defaultOptions) ->
    if typeof(options) == 'object'
      $.extend(defaultOptions, options)
    else
      defaultOptions
  scrollTo: (elem, options) ->
    elem = $(elem)
    if elem.length
      options = YmCore.addDefaults(options, {offset: 0, duration: 750})
      $('html, body').stop().animate
        scrollTop: (elem.position().top - options.offset)
      , options.duration
  Tabs:
    init: () ->
      # Activate tab from anchor
      if window.location.hash
        target_tab_link = $(".nav-tabs li a[href='#{window.location.hash}']").first()
        target_tab_link.tab('show') if target_tab_link.length
      # Highlight tabs with errors and activate first tab with errors
      $('.tab-pane').has('input.error, .control-group.error').each (idx,pane) => 
        link = $(".tabbable .nav a[href='##{$(pane).attr('id')}']")
        link.parent().addClass('error')
        link.tab('show') if idx is 0
  Bootstrap:
    init: () ->
      # $('a[data-toggle]').on 'click', event, ->
      #   event.preventDefault()
      $("[data-toggle='modal'][data-modal-url]").on 'click', -> 
        $('.temp-modal').modal('hide')
        new_modal = $("<div class='modal temp-modal'></div>")
        if (`$(this)`.data('modal-id') != undefined)
          new_modal.attr('id', `$(this)`.data('modal-id'))
        new_modal.modal({backdrop: `$(this)`.data('backdrop')})
        new_modal.load(`$(this)`.data('modal-url'))
        new_modal.on 'hidden', () ->
          `$(this)`.remove()
  Forms:
    initDatepickers: () ->
      $('.datepicker').datepicker(
        dateFormat: 'dd/mm/yy'
      )
      $('.datetime').datetimepicker(
        dateFormat: 'dd/mm/yy'
        timeFormat: 'hh:mm'
      )
      $('.timepicker').timepicker({
        timeFormat: 'hh:mm',
        stepMinute: 5
      })
    LoadingText:
      add: (elem) ->
        submitBtn = elem.find("input[type='submit']")
        loadingText = (submitBtn.data("loading-text") || 'Saving...')
        submitBtn.addClass('disabled').attr('data-non-loading-text', submitBtn.val()).val(loadingText)
      remove: (elem) ->
          submitBtn = elem.find("input[type='submit']")
          submitBtn.removeClass('disabled').val(submitBtn.data('non-loading-text'))
      init: () ->
        $(".formtastic:not('.loading-text-disabled')").on "submit", ->
          YmCore.Forms.LoadingText.add($(this))
        unless typeof(ClientSideValidations) == 'undefined'
          ClientSideValidations.callbacks.form.fail = (element, message, callback) ->
            YmCore.Forms.LoadingText.remove(element)
    init: () ->
      YmCore.Forms.LoadingText.init()
      YmCore.Forms.initDatepickers()
  Modals:
    initAutoModal: () ->
      $('#flash-modal').modal('show')
      if res = window.location.search.match(/modal=(\w+)/)
        if $("##{res[1]}").length
          $("##{res[1]}").modal('show')
          search_params = window.location.search.replace('?', '').split('&')
          search_params.splice($.inArray('modal=welcome', search_params), 1)
          if search_params.length > 0
            search_params = "?#{search_params.join('&')}"
          else
            search_params = ""
          new_href = "#{window.location.origin}#{window.location.pathname}#{search_params}"
          if history.pushState != undefined    
            history.pushState 
              path: this.path,
              '',
              new_href
  ReadMoreTruncate:
    init: () ->
      $('.read-more-link').on 'click', (event) ->
        event.preventDefault()
        wrapper = $(this).parents('.read-more-wrapper:first')
        wrapper.children('.read-more-trunc').hide()
        wrapper.children('.read-more-full').show()
      
  init: ->
    YmCore.Tabs.init()
    YmCore.Bootstrap.init()
    YmCore.Forms.init()
    YmCore.Modals.initAutoModal()
    YmCore.ReadMoreTruncate.init()

$(document).ready ->
  YmCore.init()