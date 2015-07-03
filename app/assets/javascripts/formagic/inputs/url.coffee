# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
#
# Coding Guide:
#   https://github.com/thoughtbot/guides/tree/master/style/coffeescript
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# INPUT URL
# - depends on Loft character plugin for assets management
# -----------------------------------------------------------------------------
class @InputUrl extends InputString

  _add_choose_button: ->
    @$actions =$ "<span class='input-actions'></span>"
    @$label.append @$actions

    @$chooseBtn =$ "<a href='#' class='choose'>Choose or upload a file</a>"
    @$actions.append @$chooseBtn

    @$chooseBtn.on 'click', (e) =>
      e.preventDefault()

      chr.modules.loft.showModal 'all', false, (objects) =>
        url = objects[0].file.url
        @updateValue(url)


  # PUBLIC ================================================

  initialize: ->
    @_add_choose_button()
    @config.onInitialize?(this)


chr.formInputs['url'] = InputUrl
