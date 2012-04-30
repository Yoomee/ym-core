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
      $('a[data-toggle]').live 'click', event, ->
        event.preventDefault()
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
    init: () ->
      $('.formtastic').live "submit", ->
        submitBtn = $(this).find("input[type='submit']")
        loadingText = (submitBtn.data("loading-text") || 'Saving...')
        submitBtn.addClass('disabled').val(loadingText)
      YmCore.Forms.initDatepickers()
  init: ->
    YmCore.Tabs.init()
    YmCore.Bootstrap.init()
    YmCore.Forms.init()

$(document).ready ->
  YmCore.init()