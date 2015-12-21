# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT CHECKBOX SWITCH
# -----------------------------------------------------------------------------
class @InputCheckboxSwitch extends InputCheckbox

  # PRIVATE ===================================================================

  _add_input: ->
    @$switch =$ "<div class='switch'>"
    @$el.append @$switch

    @$false_hidden_input =$ "<input type='hidden' name='#{ @name }' value='false' />"
    @$switch.append @$false_hidden_input

    @$input =$ "<input type='checkbox' id='#{ @name }' name='#{ @name }' value='true' #{ if @_safe_value() then 'checked' else '' } />"
    @$switch.append @$input

    @$checkbox =$ "<div class='checkbox'>"
    @$switch.append @$checkbox

chr.formInputs['switch'] = InputCheckboxSwitch
