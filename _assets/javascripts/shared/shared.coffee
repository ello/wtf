root = exports ? this
root.ElloWTFShared =
  init: () ->
    ElloWTFShared.watchSearchHeader()
    ElloWTFShared.watchURLSearchTerms()
    ElloWTFShared.watchDrawerToggle()
    ElloWTFShared.mobileWatchSearchToggle()
    ElloWTFShared.mobileDrawerCategoryWatch()
    ## temp for dev
    ElloWTFShared.toggleLoggedIn()

  # initAjax: () ->
  #   ElloWTFShared.doAThing()
  
  watchSearchHeader: ->
    $search_form = $(".search_holder .form")
    $search_box = $search_form.find("input")

    $search_box.keyup $.debounce((->
      # console.log $search_box.val()
      search_term = $search_box.val()
      if search_term != ""
        $search_form.removeClass("inactive")
        if search_term.length > 2
          ElloWTFSearch.searchIndex(search_term)
          $(".content h1 .search_term em").text("#{search_term}")
      else
        $search_form.addClass("inactive")
        ElloWTFSearch.clearResults()
      return
    ), 150)

    $search_box.on "focusin", ->
      $(".search_holder").addClass("active")
    $search_box.on "focusout", ->
      $(".search_holder").removeClass("active")

    $search_form.find(".clear_search").click (e) ->
      e.preventDefault()
      $search_box.val("")
      $search_form.addClass("inactive")
      $search_box.focus()
      ElloWTFSearch.clearResults()

  watchURLSearchTerms: ->
    search_term = ElloWTFShared.getURLParameter("for")
    unless typeof search_term == "undefined" || search_term == ""
      decoded_search_term = decodeURIComponent(search_term).replace(/\+/g , " ")
      $(".search_holder .form input").val("#{decoded_search_term}")
      $(".search_holder .form").removeClass("inactive")
      $(".search_holder").addClass("expanded")
      if $("body.search").length
        $(".content h1 .search_term em").text("#{decoded_search_term}")

  ## temp to fake logged in experience
  toggleLoggedIn: ->
    logged_in = ElloWTFShared.getURLParameter("logged_in")
    if logged_in == "true"
      $("body").addClass("logged_in")

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

  mobileDrawerCategoryWatch: ->
    $(".category.main h2").click (e) ->
      if $(window).width() < 720
        e.preventDefault()

      $category = $(this).parents(".category")
      if $category.hasClass("expanded")
        $category.removeClass("expanded")
      else
        $(".category.main").each ->
          $(this).removeClass("expanded")
        $(this).parents(".category").toggleClass("expanded")

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
