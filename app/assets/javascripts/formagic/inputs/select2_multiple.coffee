# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# SELECT MULTIPLE
# -----------------------------------------------------------------------------
# Dependencies:
#= require ./select2
# -----------------------------------------------------------------------------
class @InputSelect2Multiple extends InputSelect2
  initialize: ->
    @config.beforeInitialize?(this)

    target = @config.target
    titleFieldName = @config.titleField

    # Remove name from the select input so it's value is not send to the server
    @$input.attr('name', '').attr('multiple', true)

    # Attach hidden input to store value
    @$hiddenInput =$ "<input type='hidden' name='[__LIST__#{ target }]' />"
    @$el.append @$hiddenInput

    # Add handler that updates hidden value on select change (updated by select2)
    @$input.on 'change', (e) =>
      @_update_hidden_input_value()

    # These methods run while initialization only
    @_initialize_selected_values()
    @_update_hidden_input_value()

    options =
      placeholder: @config.placeholder
      multiple: true
      width: '100%'
      ajax:
        url: @config.url
        dataType: 'json'
        delay: 250
        cache: true
        minimumInputLength: 2
        data: (params) -> { search: params.term, page: 1, perPage: 20 }
        processResults: (data, page) ->
          { results: $.map data, (i) -> { id: i._id, text: i[titleFieldName] } }

    # https://select2.github.io/options.html
    $.extend(options, @config.pluginOptions || {})
    @$input.select2(options)

    @config.onInitialize?(this)

# PRIVATE =====================================================================

  _selected_ids: ->
    $.map @$input.children(':selected'), (option) ->
      $(option).attr('value')

  _selected_ids_and_names: ->
    $.map input.$input.children(':selected'), (option) ->
      { _id: $(option).attr('value'), name: $(option).text() }

  # Add initial values to be shown by select2
  _initialize_selected_values: ->
    titleFieldName = @config.titleField
    for o in @value
      @$input.append """
        <option value='#{ o._id }' selected>
          #{ o[titleFieldName] }
        </option>"""

  # Pass value to hidden input in list format (split ids with ,)
  _update_hidden_input_value: ->
    selectedValues = @_selected_ids()
    val = selectedValues.join('|||')
    @$hiddenInput.val(val)

# PUBLIC ======================================================================

  # Override default updateValue method
  updateValue: (@value) ->
    @$input.html('')
    @_initialize_selected_values()
    @_update_hidden_input_value()

  # Override hash method to cache values properly
  hash: (hash={}) ->
    hash[@config.klassName] = @_selected_ids_and_names()
    return hash

chr.formInputs['selectMultiple'] = InputSelect2Multiple
