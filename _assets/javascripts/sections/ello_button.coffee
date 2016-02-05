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
    updateIFrameDimensionsAndSize = (size) ->
      $("#ello_button textarea").each ->
        size = 'large' if (size == undefined || size == '')
        switch size
          when 'small'  then dimension = "'18'"
          when 'medium' then dimension = "'24'"
          when 'large'  then dimension = "'40'"
          else null
        $textarea    = $(this)
        # grabbing the default width and height dimension
        defaultDim   = /'40'/gi
        # grab the default script
        script       = $textarea.data('original-code')
        # split at the height
        scriptParsed = script.split('height=')
        # insert the new dimension, and replace all default dimensions
        scriptBuilt  = "#{scriptParsed[0]}height=#{dimension}#{scriptParsed[1].replace(defaultDim,'')}"
        # replace width with the new dimension
        scriptBuilt  = scriptBuilt.replace('width=', "width=#{dimension}")
        # remove the default size
        scriptBuilt  = scriptBuilt.replace('large', '')
        # replace size with the new size
        scriptBuilt  = scriptBuilt.replace('size=', "size=#{size}")
        # grab the entered username
        username = $('#ello_button input.username').val()
        # reassign username if blank or undefined
        if (username == undefined || username == '') then username = 'ello'
        # replace username with the entered username
        scriptBuilt = scriptBuilt.replace('username=ello', "username=#{username}")
        # insert it into the textarea
        $textarea.val(scriptBuilt)

    updateButtonIcon = (size) ->
      size = 'large' if (size == undefined || size == '')
      switch size
        when 'small'  then size = "18"
        when 'medium' then size = "24"
        when 'large'  then size = "40"
        else null

      # grabbing all of the ello icons
      $elloIcons = $('span.button-holder').children().children()
      # iterating through the icons and changing their width
      for icon in $elloIcons
        icon.style.width = size

    $(document).on "change", "input[type=radio]", ->
      size     = $(this).val()
      username = $('#ello_button input.username').val()
      updateIFrameDimensionsAndSize(size)
      updateButtonIcon(size)

$(document).ready ->
  if $("#ello_button").length
    ElloWTFElloButton.init()
