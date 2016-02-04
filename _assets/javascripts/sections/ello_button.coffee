root = exports ? this
root.ElloWTFElloButton =
  init: () ->
    ElloWTFElloButton.watchUsernameInput()
    ElloWTFElloButton.watchCodeSelect()
    ElloWTFElloButton.watchSizeSelect()

  watchUsernameInput: ->
    updateUsername = (username) ->
      $("#ello_button textarea").each ->
        username = 'ello' if (username == undefined || username == '')
        $textarea = $(this)
        # grab the default script
        script = $textarea.data('original-code')
        # split it at the username call
        scriptParsed = script.split('username=')
        # insert the username / clean it of the default 'ello' username
        scriptBuilt = "#{scriptParsed[0]}username=#{username}#{scriptParsed[1].replace('ello','')}"
        # insert it into the textarea
        $textarea.val(scriptBuilt)

    $(document).on "keyup", "#ello_button input.username", ->
      username = $(this).val()
      updateUsername(username)

    # might be overkill, but just in case we miss an auto-population
    $(document).on "blur", "#ello_button input.username", ->
      username = $(this).val()
      updateUsername(username)

  watchCodeSelect: ->
    $(document).on "focus", "#ello_button textarea", ->
      $(this).select()

      $(this).mouseup ->
        # Prevent further mouseup intervention
        $(this).unbind("mouseup")
        return false

  watchSizeSelect: ->
    updateSize = (size) ->
      $("#ello_button textarea").each ->
        size = 'medium' if (size == undefined || size == '')
        $textarea = $(this)
        script = $textarea.data('original-code')
        scriptParsed = script.split('size=')
        scriptBuilt = "#{scriptParsed[0]}size=#{size}#{scriptParsed[1].replace('medium','')}"
        $textarea.val(scriptBuilt)

    $(document).on "change", "input[type=radio]", ->
      size = $(this).val()
      updateSize(size)

$(document).ready ->
  if $("#ello_button").length
    ElloWTFElloButton.init()
