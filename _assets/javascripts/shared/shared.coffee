root = exports ? this
root.ElloWTFShared =
  init: () ->
    ElloWTFShared.watchSearchHeader()

  # initAjax: () ->
  #   ElloWTFShared.doAThing()
  
  watchSearchHeader: ->
    $search_form = $(".search_holder .form")
    $search_box = $search_form.find("input")

    $search_box.keyup ->
      # console.log $search_box.val()
      if $search_box.val() != ""
        $search_form.removeClass("inactive")
      else
        $search_form.addClass("inactive")

    $search_box.on "focusin", ->
      $(".search_holder").addClass("active")
    $search_box.on "focusout", ->
      $(".search_holder").removeClass("active")


    $search_form.find(".clear_search").click (e) ->
      e.preventDefault()
      $search_box.val("")
      $search_form.addClass("inactive")


  
$(document).ready ->
  ElloWTFShared.init()
