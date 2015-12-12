# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT URL
# - depends on Loft character plugin for assets management
# -----------------------------------------------------------------------------
class @InputUrl extends InputString

  _add_choose_button: ->
    @$actions =$ "<span class='input-actions'></span>"
    @$el.append @$actions

    @$chooseBtn =$ "<button>Pick a file</button>"
    @$actions.append @$chooseBtn

    @$chooseBtn.on 'click', (e) =>
      chr.modules.loft.showModal 'all', false, (objects) =>
        url = objects[0].file.url
        @updateValue(url)

  # PUBLIC ====================================================================

  initialize: ->
    @_add_choose_button()
    @config.onInitialize?(this)

chr.formInputs['url'] = InputUrl
