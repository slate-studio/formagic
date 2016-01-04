# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT DATE
# -----------------------------------------------------------------------------
# Dependencies:
#= require vendor/datedropper
#= require vendor/moment
# -----------------------------------------------------------------------------
class @InputDate extends InputString

  # PRIVATE ===================================================================

  _update_date_label: ->
    date = @$input.val()

    if date
      date_formatted = moment(date).format("dddd, MMMM Do, YYYY")

    else
      date_formatted = "<span class='placeholder'>Pick a date</span>"

    @$dateLabel.html(date_formatted)

  _add_input: ->
    @$input =$ "<input type='text' name='#{ @name }' value='#{ @_safe_value() }' class='input-datetime-date' />"
    @$el.append @$input
    @$input.on 'change', (e) => @_update_date_label()

    @$dateLabel =$ "<div class='input-date-label'>"
    @$el.append @$dateLabel
    @$dateLabel.on 'click', (e) => @$input.trigger 'click'

    @_update_date_label()

    @_add_actions()

  _add_actions: ->
    @$actions =$ "<span class='input-actions'></span>"
    @$label.append @$actions

    if not @config.disableClear
      @_add_clear_button()

  _add_clear_button: ->
    @$removeBtn =$ "<button class='clear'>Clear</button>"
    @$actions.append @$removeBtn

    @$removeBtn.on 'click', (e) =>
      @updateValue('')
      @_update_date_label()

  # PUBLIC ====================================================================

  initialize: ->
    @config.beforeInitialize?(this)

    # http://felicegattuso.com/projects/datedropper/
    @config.pluginConfig ?= {}

    config =
      animation: 'fadein'
      format:    'Y-m-d'
      maxYear:   new Date().getFullYear() + 5

    $.extend(config, @config.pluginConfig)

    @$input.dateDropper(config)

    @config.onInitialize?(this)

  updateValue: (@value) ->
    @$input.val(@value)
    @_update_date_label()

chr.formInputs['date'] = InputDate
