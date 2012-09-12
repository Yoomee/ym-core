#= require jquery-ui-1.8.18.min
#= require jquery-ui-timepicker-addon

window.YmCore =
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
      # $('a[data-toggle]').live 'click', event, ->
      #   event.preventDefault()
      $("[data-toggle='modal'][data-modal-url]").live 'click', -> 
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
    init: () ->
      $(".formtastic:not('.loading-text-disabled')").live "submit", ->
        submitBtn = $(this).find("input[type='submit']")
        loadingText = (submitBtn.data("loading-text") || 'Saving...')
        submitBtn.addClass('disabled').val(loadingText)
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
      $('.read-more-link').live 'click', (event) ->
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