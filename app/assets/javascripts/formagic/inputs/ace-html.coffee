# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT HTML
# -----------------------------------------------------------------------------
# Config options:
#   label        - Input label
#   pluginConfig - Custom options for overriding default ones
#
# Input config example:
#   body_html: { type: 'html', label: 'Article' }
#
# Dependencies:
#= require ./ace
#= require vendor/mode-html
# -----------------------------------------------------------------------------
class @InputHtml extends InputAce

  # PRIVATE ===================================================================

  _set_mode: ->
    @session.setMode("ace/mode/html")

chr.formInputs['html'] = InputHtml
