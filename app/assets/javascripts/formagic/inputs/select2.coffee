# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT SELECT 2
# -----------------------------------------------------------------------------
#
# Dependencies:
#= require vendor/select2
#
# -----------------------------------------------------------------------------
class @InputSelect2 extends InputSelect
  initialize: ->
    @config.beforeInitialize?(this)

    # https://select2.github.io/options.html
    options = @config.pluginOptions || { placeholder: @config.placeholder }
    @$input.select2(options)

    @config.onInitialize?(this)

chr.formInputs['select2'] = InputSelect2
