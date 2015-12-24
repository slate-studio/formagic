# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT MARKDOWN
# -----------------------------------------------------------------------------
# Markdown input supports syntax highlighting and optional compilation to html.
#
# Config options:
#   label          - Input label
#   pluginConfig   - Custom options for overriding default ones
#   getHtmlInput   - return input so store generated HTML content
#   disableToolbar - Do not show shorcuts panel
#
# Input config example:
#   body_md:
#     type: 'markdown'
#     label: 'Article'
#     getHtmlInput: -> chr.module.view.form.inputs.body_html
#
# Dependencies:
#= require ./ace
#= require vendor/marked
#= require vendor/ace
#= require vendor/mode-markdown
#= require ./ace-markdown_toolbar
# -----------------------------------------------------------------------------
class @InputMarkdown extends InputAce
  # PRIVATE ===================================================================

  _before_initialize: ->
    @config.imageSize ||= "large"
    if ! @config.disableToolbar
      @_add_toolbar()

  _update_inputs: ->
    markdown = @session.getValue()
    @$input.val(markdown)
    @$input.trigger('change')

    if @config.getHtmlInput
      html = marked(markdown)
      input = @config.getHtmlInput()
      input.updateValue(html)

  _set_mode: ->
    @session.setMode("ace/mode/markdown")

include(InputMarkdown, inputMarkdownToolbar)

chr.formInputs['markdown'] = InputMarkdown
