root = exports ? this
root.ElloWTFElloButton =
  init: () ->
    ElloWTFElloButton.watchUsernameInput()
    ElloWTFElloButton.watchCodeSelect()

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

$(document).ready ->
  if $("#ello_button").length
    ElloWTFElloButton.init()
