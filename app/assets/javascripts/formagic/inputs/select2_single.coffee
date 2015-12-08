# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# SELECT SINGLE
# -----------------------------------------------------------------------------
#
# Dependencies:
#= require ./select2
#
# -----------------------------------------------------------------------------
# Configuration example:
#
#   category_id:
#     type: 'selectSingle'
#     label: 'Category'
#     titleField: 'title'
#     url: "/admin/categories.json"
#     relatedTitleField: 'category_title'
#
# -----------------------------------------------------------------------------
class @InputSelect2Multiple extends InputSelect2
  initialize: ->
    @config.beforeInitialize?(this)

    titleFieldName = @config.titleField
    @_initialize_options_hash(titleFieldName)

    options =
      placeholder: @config.placeholder
      width: "100%"
      ajax:
        url: @config.url
        dataType: 'json'
        delay: 250
        cache: true
        minimumInputLength: 2
        data: (params) -> { search: params.term, page: 1 }
        processResults: (data, page) ->
          { results: $.map data, (i) -> { id: i._id, text: i[titleFieldName] } }

    # https://select2.github.io/options.html
    $.extend(options, @config.pluginOptions || {})
    @$input.select2(options)

    @config.onInitialize?(this)

# PRIVATE =====================================================================

  _initialize_options_hash: ->
    @config.optionsHash = {}
    if @object
      relatedObjectId = @object[@config.fieldName]
      relatedObjectTitle = @object[@config.relatedTitleField]
      if ! relatedObjectTitle
        relatedObjectTitle = 'None'
      @config.optionsHash[relatedObjectId] = relatedObjectTitle
    @_add_options()

chr.formInputs['selectSingle'] = InputSelect2Multiple
