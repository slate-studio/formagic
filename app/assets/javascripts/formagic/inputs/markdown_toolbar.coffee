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
    if @isFixed
      return
      # some legacy workaround for mobile:
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
    if ! @isFixed then return

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

  _insert_link: (editor) ->
    url = prompt("URL", "")
    if url
      title = editor.getSelectedText()
      if title == "" then title = url
      editor.insert "[#{title}](#{url})"
    editor.focus()

  _insert_images: (editor) ->
    chr.modules.loft.showModal "images", true, (objects) ->
      for image in objects
        editor.insert "![#{image.name}](#{image.file.url})\n"
    editor.focus()
