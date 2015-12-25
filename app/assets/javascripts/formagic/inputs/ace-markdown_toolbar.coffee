# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT MARKDOWN TOOLBAR
# -----------------------------------------------------------------------------
class @InputMarkdownToolbar
  constructor: (@input) ->
    @$el =$ "<div class='toolbar'>"

    @topOffset = 40
    @isFixed = false

    @_bind_window_scroll()

  # PRIVATE ===================================================================

  _is_visible: ->
    @$el.is(":visible")

  _bind_window_scroll: ->
    @$window =$ ".content:visible"
    @$window.on "scroll", => @_check_offset()

  _height: ->
    toolbarBottomMargin = parseInt @$el.css("margin-bottom")
    toolbarHeight = @$el.outerHeight() + toolbarBottomMargin

  _check_offset: ->
    @$ace = @input.$editor
    aceOffset = @$ace.offset()
    isBelowAceTop = aceOffset.top - @topOffset - @_height() <= 0
    isAboveAceBottom = @$ace.outerHeight() + aceOffset.top -
                       @topOffset - @$el.outerHeight() >= 0
    if isBelowAceTop && isAboveAceBottom then @_fix() else @_unfix()

  _fix: ->
    if @isFixed || ! @_is_visible() then return
      # TODO: make this work on mobile ...
      # webkit does not recalc top: 0 when focused on contenteditable
      # if chr.isMobile() && @isFocused
      #   @$el.css
      #     position: "absolute"
      #     top: @$window.scrollTop() - @$ace.offset().top

    @$ace = @input.$editor
    @$el.css
      position: "fixed"
      top: @topOffset
      width: @input.$el.outerWidth()
      zIndex: 300
    @$ace.css("margin-top", @_height())
    @isFixed = true

  _unfix: ->
    if ! @isFixed || ! @_is_visible() then return

    @$ace = @input.$editor
    @$el.css
      position: 'relative'
      left: ''
      width: ''
      top: ''
    @$ace.css('margin-top', '')
    @isFixed = false

  # PUBLIC ====================================================================

  addButton: (title, callback=$.noop) ->
    @buttons ||= {}
    $btn =$ "<button>#{title}</button>"
    $btn.on "click", (e) => callback(@input.editor)
    @$el.append $btn
    @buttons[title] = $btn

@inputMarkdownToolbar =

  # PRIVATE ===================================================================

  _add_toolbar: ->
    @toolbar = new InputMarkdownToolbar(this)
    @$label.after @toolbar.$el

    @toolbar.addButton "Link", $.proxy(@_insert_link, this)
    @toolbar.addButton "Image", $.proxy(@_insert_images, this)
    @toolbar.addButton "File", $.proxy(@_insert_files, this)

  _insert_link: (editor) ->
    url = prompt("URL", "")
    if url
      title = editor.getSelectedText()
      if title == "" then title = url
      editor.insert "[#{title}](#{url})"
    editor.focus()

  _insert_images: (editor) ->
    # TODO: add workaround when loft is not available
    onAccept = (objects) =>
      for image in objects
        name = image.name
        url = image.file[@config.imageSize].url
        editor.insert "![#{name}](#{url})\n"
      editor.focus()
    onCancel = -> editor.focus()
    chr.modules.loft.showImages true, onAccept, onCancel

  _insert_files: (editor) ->
    # TODO: add workaround when loft is not available
    onAccept = (objects) =>
      for file in objects
        name = file.name
        url = file.file.url
        editor.insert "[#{name}](#{url})\n"
      editor.focus()
    onCancel = -> editor.focus()
    chr.modules.loft.showDocuments true, onAccept, onCancel
