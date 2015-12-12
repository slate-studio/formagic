# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT ARRAY
# -----------------------------------------------------------------------------
# Allows to create/delete/reorder list items connected to dynamic or static
# collection. Value should be an array of objects.
#
# All items should be unique for now.
#
# Config options:
#   ignoreArrayWithEmptyString - do not show element when value is [""]
#
# Dependencies:
#= require formagic/inputs/list_reorder
#
# -----------------------------------------------------------------------------
class @InputArray extends InputString

  # PRIVATE ===================================================================

  _add_input: ->
    # hidden input that stores ids, we use __LIST__ prefix to identify
    # ARRAY input type and process it's value while form submission.
    name = if @config.namePrefix
      "#{ @config.namePrefix }[__LIST__#{ @config.klassName }]"
    else
      "[__LIST__#{ @config.klassName }]"

    @$input =$ "<input type='hidden' name='#{ name }' value='' />"
    @$el.append @$input

    # list holder for items
    @reorderContainerClass = @config.klassName
    @$items =$ "<ul class='#{ @reorderContainerClass }'></ul>"
    @$el.append @$items

    @config.placeholder ||= 'Add new value'
    @_create_string_input_el(@config.placeholder)

    @_render_items()
    @_update_input_value()

  _values: ->
    @$items.children('li').map((i, el) -> $(el).data('value')).get()

  _update_input_value: ->
    input_value = @_values().join('|||')

    @$input.val(input_value)
    @$input.trigger('change')

  _remove_item: ($el) ->
    $el.parent().remove()
    @_update_input_value()

  _render_items: ->
    @$items.html('')

    if @config.ignoreArrayWithEmptyString
      if @value.length == 1 && @value[0] == ""
        return

    for v in @value
      @_render_item(v)

  _render_item: (o) ->
    value = _escapeHtml(o)
    listItem =$ """<li data-value='#{ value }'>
                     <span class='icon-reorder'
                           data-container-class='#{ @reorderContainerClass }'>
                       #{ Icons.reorderDocuments }
                     </span>
                     #{ value }
                     <a href='#' class='action_remove'>Remove</a>
                   </li>"""
    @$items.append(listItem)

    @_update_input_value()

  _create_string_input_el: (placeholder) ->
    @$stringInput =$ "<input type='text' placeholder='#{ placeholder }' />"
    @$el.append @$stringInput

  _bind_string_input: ->
    @$stringInput.on 'keydown', (e) =>
      if e.keyCode == 13
        val = $(e.currentTarget).val()
        @_render_item(val)
        $(e.currentTarget).val('')

  # PUBLIC ====================================================================

  initialize: ->
    @config.beforeInitialize?(this)

    # input for new values
    @_bind_string_input()

    # remove
    @$items.on 'click', '.action_remove', (e) =>
      e.preventDefault()
      if confirm('Are you sure?') then @_remove_item($(e.currentTarget))

    @_bind_reorder()

    @config.onInitialize?(this)

  updateValue: (@value) ->
    @_render_items()

  hash: (hash={}) ->
    hash[@config.klassName] = @_values()
    return hash

include(InputArray, inputListReorder)

chr.formInputs['array'] = InputArray
