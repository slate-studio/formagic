# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
#
# Coding Guide:
#   https://github.com/thoughtbot/guides/tree/master/style/coffeescript
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# INPUT DOCUMENT
# -----------------------------------------------------------------------------
# 1-to-1 relation implementation. This is based on InputDocuments
# implementation and might require refactor.
#
# Public methods:
#   initialize()
#   hash(hash)
#   updateValue(@value)
#   showErrorMessage(message)
#   hideErrorMessage()
#
# -----------------------------------------------------------------------------

class @InputDocument
  constructor: (@name, @nestedObject, @config, @object) ->
    @forms = []

    @config.namePrefix         ||= name
    @config.removeButton         = true
    @config.ignoreOnSubmission ||= false

    if @config.ignoreOnSubmission
      for key, inputConfig of @config.formSchema
        inputConfig.ignoreOnSubmission = true

    @_create_el()

    @_add_label()
    @_add_forms()

    return this


  # PRIVATE ===============================================

  _create_el: ->
    @$el =$ "<div class='form-input nested-forms input-#{ @config.klassName }'>"


  _add_label: ->
    @$label =$ "<span class='label'>#{ @config.label }</span>"
    @$errorMessage =$ "<span class='error-message'></span>"
    @$label.append(@$errorMessage)
    @$el.append(@$label)


  _add_forms: ->
    @nestedForm = @_render_form(@nestedObject, @config.namePrefix, @config)

    @forms = [ @nestedForm ]

    @$form = @nestedForm.$el
    @$label.after @$form


  _render_form: (object, namePrefix, config) ->
    formConfig = $.extend {}, config,
      namePrefix:   namePrefix
      rootEl:       "<div>"
      removeButton: false

    form = new Form(object, formConfig)
    return form


  # PUBLIC ================================================

  initialize: ->
    @config.beforeInitialize?(this)

    @nestedForm.initializePlugins()

    @config.onInitialize?(this)


  hash: (hash={}) ->
    objects = []
    hash[@config.fieldName] = @nestedForm.hash()
    return hash


  showErrorMessage: (message) ->
    @$el.addClass 'error'
    @$errorMessage.html(message)


  hideErrorMessage: ->
    @$el.removeClass 'error'
    @$errorMessage.html('')


  updateValue: (@nestedObject, @object) ->
    for name, value of @nestedObject
      if @nestedForm.inputs[name]
        @nestedForm.inputs[name].updateValue(value, @object)


chr.formInputs['document'] = InputDocument




