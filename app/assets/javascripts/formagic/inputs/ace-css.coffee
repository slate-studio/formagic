# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT CSS
# -----------------------------------------------------------------------------
# Config options:
#   label        - Input label
#   pluginConfig - Custom options for overriding default ones
#
# Input config example:
#   css_field: { type: 'css', label: 'Styles' }
#
# Dependencies:
#= require ./ace
#= require vendor/mode-css
# -----------------------------------------------------------------------------
class @InputCss extends InputAce

  # PRIVATE ===================================================================

  _set_mode: ->
    @session.setMode("ace/mode/css")

chr.formInputs['css'] = InputCss
