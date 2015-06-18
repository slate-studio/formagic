# -----------------------------------------------------------------------------
# INPUT FILE IMAGE
# -----------------------------------------------------------------------------
# Config options:
#   thumbnail(object) - method that returns thumbnail for input
# -----------------------------------------------------------------------------
class @InputFileImage extends InputFile
  _add_input: ->
    @$link =$ "<a href='#' target='_blank' title=''></a>"
    @$el.append @$link

    @$thumb =$ "<img src='' />"
    @$el.append @$thumb

    @$input =$ "<input type='file' name='#{ @name }' id='#{ @name }' />"
    @$el.append @$input

    @_add_clear_button()
    @_add_remove_checkbox()


  _update_inputs: ->
    @$link.html(@filename).attr('title', @filename).attr('href', @value.url)
    image_thumb_url = if @config.thumbnail then @config.thumbnail(@object) else @value.url
    @$thumb.attr('src', image_thumb_url).attr('alt', @filename)


chr.formInputs['image'] = InputFileImage
