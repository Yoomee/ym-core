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
  init: ->
    YmCore.Tabs.init()
    YmCore.Bootstrap.init()
      

$(document).ready ->
  YmCore.init()
