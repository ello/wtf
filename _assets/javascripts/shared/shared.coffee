root = exports ? this
root.ElloWTFShared =
  init: () ->
    ElloWTFShared.watchSearchHeader()
    ElloWTFShared.watchSearchTerms()
    ElloWTFShared.watchDrawerToggle()
    ElloWTFShared.mobileWatchSearchToggle()

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
      $search_box.focus()

  ## temp to fake search experience
  watchSearchTerms: ->
    search_term = ElloWTFShared.getURLParameter('search')
    unless typeof search_term == 'undefined' || search_term == ""
      $(".search_holder .form input").val("#{search_term}")
      $(".search_holder .form").removeClass("inactive")
      $(".search_holder").addClass("expanded")

  watchDrawerToggle: ->
    $("header.top .drawer_toggle a").click (e) ->
      e.preventDefault()
      $('body').toggleClass('drawer_open')
      $('body').scrollTop 0

  mobileWatchSearchToggle: ->
    $(".search_holder .trigger .search").click (e) ->
      e.preventDefault()

      $search_form = $(".search_holder")
      $search_box = $search_form.find("input")
      if $search_form.hasClass("expanded")
        $search_form.removeClass("expanded")
      else
        $search_form.addClass("expanded")
        $search_box.focus()

  getURLParameter: (parameter) ->
    page_url = window.location.search.substring(1)
    url_variables = page_url.split("&")
    i = 0
    while i < url_variables.length
      parameter_name = url_variables[i].split("=")
      if parameter_name[0] == parameter
        return parameter_name[1]
      i++
    return


  
$(document).ready ->
  ElloWTFShared.init()
