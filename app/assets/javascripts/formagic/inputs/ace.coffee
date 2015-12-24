# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# ABSTRACT ACE EDITOR
# -----------------------------------------------------------------------------
# Dependencies:
#= require vendor/ace
# -----------------------------------------------------------------------------
class @InputAce extends InputString

  # PRIVATE ===================================================================

  _add_input: ->
    @$input =$ "<input type='hidden' name='#{ @name }' value='#{ @_safe_value() }' />"
    @$el.append @$input

    @$editor =$ "<div>"
    @$el.append @$editor

  _update_inputs: ->
    @value = @session.getValue()
    @$input.val(@value)
    @$input.trigger("change")

  _set_mode: ->

  # ace options: https://github.com/ajaxorg/ace/wiki/Configuring-Ace
  _default_options: ->
    autoScrollEditorIntoView: true
    minLines:                 8
    maxLines:                 Infinity
    showLineNumbers:          false
    showGutter:               false
    highlightActiveLine:      false
    showPrintMargin:          false
    tabSize:                  2

  # PUBLIC ====================================================================

  initialize: ->
    @_before_initialize?()
    @config.pluginConfig ||= {}
    @config.beforeInitialize?(this)

    @editor = ace.edit(@$editor.get(0))
    @editor.$blockScrolling = Infinity

    @session = @editor.getSession()
    @session.setUseWorker(false)
    @session.setValue(@$input.val())
    @session.setUseWrapMode(true)
    @_set_mode()

    aceOptions = @_default_options()
    $.merge(aceOptions, @config.pluginConfig)
    @editor.setOptions(aceOptions)

    @session.on "change", (e) => @_update_inputs()
    @_after_initialize?()
    @config.onInitialize?(this)

  updateValue: (@value) ->
    @session.setValue(@value)
