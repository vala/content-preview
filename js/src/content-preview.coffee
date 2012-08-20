class ContentPreview
  constructor: (@state = null) ->

  process: (str, callback) ->
    url = @parseStr(str)
    # Only request informations if
    unless !url || url == state
      requestPreview(url, callback)

  # Perse
  parseStr: (str) ->
    urls = str.match(/(http\:\/\/[^\s]+)/)
    # Return first occurence
    urls[1] if urls

  # Send request to remote service
  requestPreview: (url, callback) ->
    $.post ContentPreview.url, { content: url }, ((resp) => processResponse(resp, callback)), 'json'

  # Response handling
  processResponse: (resp, callback) ->
    callback(resp) if resp

# Singleton method for simpler use
ContentPreview.parse = (str, cb, state = null) ->
  preview = new ContentPreview(state)
  preview.process str, cb

# Server url config
ContentPreview.url = ""


$.fn.parseContentPreview = (str, callback) ->
  this.each ->
    # Get preview object or build a new if none exist
    preview = $(this).data('content-preview')
    preview = new ContentPreview() unless preview
    # Process str
    preview.process str, callback

# Expose
window.ContentPreview = ContentPreview

