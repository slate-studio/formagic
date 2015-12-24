# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT JS
# -----------------------------------------------------------------------------
# Config options:
#   label        - Input label
#   pluginConfig - Custom options for overriding default ones
#
# Input config example:
#   js_field: { type: 'js', label: 'JavaScript' }
#
# Dependencies:
#= require ./ace
#= require vendor/mode-javascript
# -----------------------------------------------------------------------------
class @InputJs extends InputAce

  # PRIVATE ===================================================================

  _set_mode: ->
    @session.setMode("ace/mode/javascript")

chr.formInputs['js'] = InputJs
