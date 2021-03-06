# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT TEXT
# -----------------------------------------------------------------------------
# Dependencies:
#= require vendor/jquery.scrollparent
#= require vendor/jquery.textarea_autosize
# -----------------------------------------------------------------------------
class @InputText extends InputString
  # PRIVATE ===================================================================

  _add_input: ->
    @$input =$ "<textarea class='autosize' name='#{ @name }' rows=1>#{ @_safe_value() }</textarea>"
    # trigger change event on keyup so value is cached while typing
    @$input.on 'keyup', (e) => @$input.trigger('change')
    @$el.append @$input

  # PUBLIC ====================================================================

  initialize: ->
    @config.beforeInitialize?(this)

    @$input.textareaAutoSize()

    @config.onInitialize?(this)

  updateValue: (@value) ->
    @$input.val(@value)
    @$input.trigger 'keyup'

chr.formInputs['text'] = InputText
