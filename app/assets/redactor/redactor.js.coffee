#= require redactor/redactor

RLANG.media = "Insert Media..."
RLANG.media_url = "Enter the URL of a video on Youtube or Vimeo"
RLANG.media_html_code = "Media embed code"

window.EmbeddableMedia = 
  hosts:
    youtube:
      regex: /(https?:\/\/)?(www.)?youtube.com\/watch[^\s<]*v=([\w|-]+)[^\s<]*/
      embed: "<iframe src='http://www.youtube.com/embed/#ID#'  width='560' height='315' frameborder='0' allowfullscreen></iframe>"
    vimeo:
      regex: /(https?:\/\/)?(www.)?vimeo.com\/(\d+)/
      embed: "<iframe src='http://player.vimeo.com/video/#ID#' width='560' height='315' frameborder='0' allowFullScreen webkitAllowFullScreen mozallowfullscreen></iframe>"
    
  embedCode: (url) ->
    ec = ""
    host_matches = url.match(/https?:\/\/(www\.)?([^:\/?#\.]*)/)
    if host_matches? && host = EmbeddableMedia.hosts[host_matches[2]]
      url_matches = url.match(host.regex)
      if url_matches 
        ec = host.embed.replace('#ID#', url_matches[3])

window.Redactor=
  init: ->
    $('textarea.redactor').redactor
      path:'/assets/redactor',
      convertDivs: false,
      buttons: [
        'bold',
        'italic',
        'formatting',
        '|',
        'unorderedlist',
        'orderedlist',
        '|',
        'link',
        'media',
        'html',
        'fullscreen'
      ],
      buttonsCustom:
        media:
          title: RLANG.media
          func: 'showMedia'
      modal_media: "
        <form id='redactorInsertVideoForm'>
          <label>#{RLANG.media_url}</label>
          <input type='text' id='redactor_insert_media_url_input' style='width: 99%;'>
          <a href='#' data-toggle='collapse' data-target='#redactorMediaAdvanced'>Advanced options</a>
          <div id='redactorMediaAdvanced' class='collapse'>
            <label>#{RLANG.media_html_code}</label>
            <textarea id='redactor_insert_media_html_area' style='width: 99%; height: 120px;'></textarea>
          </div>
        </form>
        <div id='redactor_modal_footer'>
          <span class='redactor_btns_box'>
            <input type='button' id='redactor_insert_media_btn' class='btn btn-primary btn-small' value='#{RLANG.insert}'>
            <a href='javascript:void(null);' id='redactor_btn_modal_close'>
            #{RLANG.cancel}
            </a>
          </span>
        </div>"