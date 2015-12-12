# -----------------------------------------------------------------------------
# Author: Alexander Kravets <alex@slatestudio.com>,
#         Slate Studio (http://www.slatestudio.com)
# -----------------------------------------------------------------------------
# INPUT HASH
# -----------------------------------------------------------------------------
# Allows to work with hash fields in nested forms way.
# -----------------------------------------------------------------------------
class @InputHash extends InputDocument

  _create_el: ->
    @$el =$ "<div class='form-input input-hash input-#{ @config.klassName }'>"

chr.formInputs['hash'] = InputHash
