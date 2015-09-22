# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
#
# Coding Guide:
#   https://github.com/thoughtbot/guides/tree/master/style/coffeescript
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# EXPANDABLE GROUP
# -----------------------------------------------------------------------------
#
# Usage: onInitialize: (form, group) -> new ExpandableGroup(form, group, 'Details')
#
# -----------------------------------------------------------------------------

@_expandableGroupStateCache = {}

class @ExpandableGroup
  constructor: (@form, @group, name) ->
    @$expander =$ """<a href='#' class='group-edit hidden'>#{ name }</a>"""
    @group.$el.before @$expander

    @_restoreExpanderFromCache()

    @$expander.on 'click', (e) =>
      @$expander.toggleClass('hidden')
      @_cacheExpanderState()
      e.preventDefault()


  _restoreExpanderFromCache: ->
    if _expandableGroupStateCache.__hash

      if _expandableGroupStateCache.__hash == window.location.hash
        if _expandableGroupStateCache[@_groupId()]
          @$expander.removeClass 'hidden'

      if _expandableGroupStateCache.__hash.endsWith 'new'
        @$expander.removeClass 'hidden'


  _cacheExpanderState: ->
    _expandableGroupStateCache.__hash = window.location.hash
    _expandableGroupStateCache[@_groupId()] = @group.$el.is(':visible')


  _groupId: ->
    groupIndex = $('form').find(".group.#{ @group.klassName }").index(@group.$el)
    return "#{ @group.klassName }-#{ groupIndex }"
