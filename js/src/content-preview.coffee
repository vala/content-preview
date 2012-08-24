class ContentPreview
  constructor: () ->
    @state = null

  process: (str, callback) ->
    url = @parseStr(str)
    # Only request informations if we found an url
    unless !url || url == @state
      # Keep state for future preview requests
      @state = url
      @requestPreview(url, callback)

  # Parsing
  # Checking if str matches url regex
  parseStr: (str) ->
    urls = str.match(/(http\:\/\/[^\s]+)/)
    # Return first occurence
    urls[1] if urls

  # Send request to remote service
  requestPreview: (url, callback) ->
    $.get $.fn.parseContentPreview.defaultOptions.url, { url: url }, ((resp) => @processResponse(resp, callback)), 'json'

  # Response handling
  processResponse: (resp, callback) ->
    #callback(resp) if resp

    # setting preview_* values to empty
    $($.fn.parseContentPreview.defaultOptions.preview_title).text("")
    $($.fn.parseContentPreview.defaultOptions.preview_description).text("")
    $($.fn.parseContentPreview.defaultOptions.preview_image).empty()
    $(".images").empty()
    $($.fn.parseContentPreview.defaultOptions.form_hidden_inputs_name).empty()

    if resp.title
      $($.fn.parseContentPreview.defaultOptions.preview_title).text(resp.title)
      $($.fn.parseContentPreview.defaultOptions.form_hidden_inputs_name).prepend('<input type="hidden"  name="' + $.fn.parseContentPreview.defaultOptions.form_content_name + '[content_title]" value="' + resp.title + '"/>')

    if resp.description
      $($.fn.parseContentPreview.defaultOptions.preview_description).text(resp.description)
      $($.fn.parseContentPreview.defaultOptions.form_hidden_inputs_name).prepend('<input type="hidden" name="' + $.fn.parseContentPreview.defaultOptions.form_content_name + '[content_description]" value="' + resp.description + '"/>')

    if resp.image
      $($.fn.parseContentPreview.defaultOptions.preview_image).prepend('<img width="200px" src="' + resp.image + '" />')
      $($.fn.parseContentPreview.defaultOptions.form_hidden_inputs_name).prepend('<input type="hidden" name="' + $.fn.parseContentPreview.defaultOptions.form_content_name + '[content_image]" value="' + resp.image + '"/>')

    if resp.images
      resp.images.map (item) ->
        unless (item.substr(0, 7) is "http://") || (item.substr(0, 2) is "//")
          item = textarea.val() + item
        $(".images").prepend('<img id="image_remote_preview_" src="' + item + '" />')

    # show cross image if one the meta data is available
    if resp.title or resp.description or resp.image or resp.images
      $("#form-actions-cross").show()

$.fn.parseContentPreview = (str, callback) ->
  this.each ->
    # Get preview object or build a new if none exist
    # preview = $(this).data('content-preview')

    preview = new ContentPreview()
    # Process str
    preview.process str, callback

# default options
$.fn.parseContentPreview.defaultOptions = {
  url: 'http://def.rs.af.cm',
  form_content_name: 'post',
  form_hidden_inputs_name: '.hidden_inputs',
  preview_title: '#preview-title',
  preview_description: '#preview-description',
  preview_image: '#preview-image'
};

# method to select image from many images and prepend it to the form_hidden_inputs_name
preview_select_image = (image) ->
  if $("input[name='" + $.fn.parseContentPreview.defaultOptions.form_content_name + "[content_image]']").length > 0
    $("input[name='" + $.fn.parseContentPreview.defaultOptions.form_content_name + "[content_image]']").attr "value", image
  else
    $($.fn.parseContentPreview.defaultOptions.form_hidden_inputs_name).prepend "<input type='hidden' name='" + $.fn.parseContentPreview.defaultOptions.form_content_name + "[content_image]' value='" + image + "'/>"

#the tree lines above should run on page load
$("img[id='image_remote_preview_']").click (e) ->
  preview_select_image $(e.currentTarget).attr('src')
  return

$("#form-actions-cross").click (e) ->
  $($.fn.parseContentPreview.defaultOptions.preview_title).text("")
  $($.fn.parseContentPreview.defaultOptions.preview_description).text("")
  $($.fn.parseContentPreview.defaultOptions.preview_image).empty()
  $(".images").empty()
  $($.fn.parseContentPreview.defaultOptions.form_hidden_inputs_name).empty()

  $("#form-actions-cross").hide()
  return

# Expose
window.ContentPreview = ContentPreview
window.preview_select_image = preview_select_image