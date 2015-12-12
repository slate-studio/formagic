# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT PASSWORD
# -----------------------------------------------------------------------------
class @InputPassword extends InputString
  # PRIVATE ===================================================================

  _add_input: ->
    @$input =$ "<input type='password' name='#{ @name }' value='#{ @value }' />"
    @$input.on 'keyup', (e) => @$input.trigger('change')
    @$el.append @$input

  # PUBLIC ====================================================================

  updateValue: (@value) ->
    @$input.val(@value)

chr.formInputs['password'] = InputPassword
