#= require redactor/redactor

window.Redactor =
  init: ->
    $('textarea.redactor').redactor
      path:'/assets/redactor',
      buttons: [
        'bold',
        'italic',
        'formatting',
        '|',
        'unorderedlist',
        'orderedlist',
        '|',
        'link',
        'image',
        'video',
        'html',
        'fullscreen'
      ]