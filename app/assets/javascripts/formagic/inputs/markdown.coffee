# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT MARKDOWN
# -----------------------------------------------------------------------------
# Markdown input supports syntax highlighting and optional compilation to html.
#
# Config options:
#   label          - Input label
#   aceOptions     - Custom options for overriding default ones
#   htmlFieldName  - Input name for generated HTML content
#   disableToolbar - Do not show shorcuts panel
#
# Input config example:
#   body_md: { type: 'markdown', label: 'Article', htmlFieldName: 'body_html' }
#
# Dependencies:
#= require vendor/marked
#= require vendor/ace
#= require vendor/mode-markdown
#= require ./markdown_toolbar
# -----------------------------------------------------------------------------
class @InputMarkdown extends InputString
  # PRIVATE ===================================================================

  _add_input: ->
    if @config.htmlFieldName
      @$inputHtml =$ "<input type='hidden' name='[#{ @config.htmlFieldName }]' />"
      if @object
        @$inputHtml.val(@object[@config.htmlFieldName])
      @$el.append @$inputHtml

    @$input =$ "<input type='hidden' name='#{ @name }' value='#{ @_safe_value() }' />"
    @$el.append @$input

    @$editor =$ "<div></div>"
    @$el.append @$editor

    if ! @config.disableToolbar
      @_add_toolbar()

  _update_inputs: ->
    md_source = @session.getValue()
    @$input.val(md_source)
    @$input.trigger('change')

    if @$inputHtml
      html = marked(md_source)
      @$inputHtml.val(html)
      @$inputHtml.trigger('change')

  # PUBLIC ====================================================================

  initialize: ->
    @config.pluginConfig ||= {}
    @config.beforeInitialize?(this)

    @editor = ace.edit(@$editor.get(0))
    @editor.$blockScrolling = Infinity

    @session = @editor.getSession()
    @session.setValue(@$input.val())
    @session.setUseWrapMode(true)
    @session.setMode("ace/mode/markdown")

    # options: https://github.com/ajaxorg/ace/wiki/Configuring-Ace
    aceOptions =
      autoScrollEditorIntoView: true
      minLines:                 5
      maxLines:                 Infinity
      showLineNumbers:          false
      showGutter:               false
      highlightActiveLine:      false
      showPrintMargin:          false
    $.merge(aceOptions, @config.pluginConfig)

    @editor.setOptions aceOptions
    @session.on 'change', (e) => @_update_inputs()
    @_update_inputs()
    @config.onInitialize?(this)

  updateValue: (@value) ->
    @session.setValue(@value)
    @_update_inputs()

  hash: (hash={}) ->
    hash[@config.htmlFieldName] = @$inputHtml.val()
    hash[@config.klassName]     = @$input.val()
    return hash

include(InputMarkdown, inputMarkdownToolbar)

chr.formInputs['markdown'] = InputMarkdown
