YmCore =
  Tabs:
    init: () ->
      $('.tab-pane').has('input.error').each (idx,pane) => 
        link = $(".tabbable .nav a[href='##{$(pane).attr('id')}']")
        link.parent().addClass('error')
        link.tab('show') if idx is 0
  init: ->
    YmCore.Tabs.init()
      

$(document).ready ->
  YmCore.init()
