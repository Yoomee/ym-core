#= require jquery-ui-1.8.18.min

YmCore =
  Tabs:
    init: () ->
      $('.tab-pane').has('input.error').each (idx,pane) => 
        link = $(".tabbable .nav a[href='##{$(pane).attr('id')}']")
        link.parent().addClass('error')
        link.tab('show') if idx is 0        
  Bootstrap:
    init: () ->
      $('a[data-toggle]').click (event) ->
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
    init: () ->
      $('.formtastic').live "submit", ->
        submitBtn = $(this).find('.btn.btn-primary')
        loadingText = (submitBtn.data("loading-text") || 'Saving...')
        submitBtn.addClass('disabled').val(loadingText)
  init: ->
    YmCore.Tabs.init()
    YmCore.Bootstrap.init()
    YmCore.Forms.init()

$(document).ready ->
  YmCore.init()