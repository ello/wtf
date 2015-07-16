root = exports ? this
root.ElloWTFShared =
  init: () ->
    ## resize stuff
    ElloWTFShared.checkMobile()
    ElloWTFShared.masterResizeListener()
    ## other shared functions
    ElloWTFShared.watchSearchHeader()
    ElloWTFShared.watchURLSearchTerms()
    ElloWTFShared.watchDrawerToggle()
    ElloWTFShared.watchSearchToggle()
    ElloWTFShared.mobileDrawerCategoryWatch()

  checkMobile: ->
    if /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)
      if ($(window).width() < 720) ## do stuff for phones
        $('html').addClass('mobile')
        ElloWTFShared.updateOrientation()
      else
        $('html').addClass('tablet')
        ElloWTFShared.updateOrientation()
    else
      $('html').addClass('desktop')

  setOrientation: ->
    orientation = window.orientation.toString()
    orientations = {
      "0": "portrait",
      "-90": "landscape",
      "90": "landscape",
      "180": "portrait"
    }
    $("body").removeClass('portrait landscape').addClass orientations[orientation]
    # console.log "orientation is #{orientations[orientation]}!"

  updateOrientation: ->
    ElloWTFShared.setOrientation()

    ## orientation change (resize) functions here
    ElloWTFShared.resizeSearchBox()

  masterResizeListener: ->
    if $('html.mobile, html.tablet').length > 0
      $(window).on "orientationchange", -> ElloWTFShared.updateOrientation()

    unless $('html.mobile').length or $('html.tablet').length
      $(window).smartresize ->
        # console.log 'resize!'
        ## orientation resize functions here
        ElloWTFShared.resizeSearchBox()

  watchSearchHeader: ->
    $search_form = $(".search_holder .form")
    $search_box = $search_form.find("input")

    $search_box.keyup $.debounce(( (e) ->
      # console.log $search_box.val()
      search_term = $search_box.val()
      if search_term != ""
        $search_form.removeClass("inactive")
        if search_term.length > 2
          ElloWTFSearch.searchIndex(search_term)
          $("#search_content h1 .search_term em").text("#{search_term}")
          $("#search_content h1.main").show()
          $("#search_content h1.alt").hide()
      else
        $search_form.addClass("inactive")
        ElloWTFSearch.clearResults()
      return
    ), 150)

    $search_box.keydown (e) ->
      code = e.keyCode || e.which
      if code == 13
        ElloWTFSearch.invokeSearch()
        return false


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
      $("#search_content h1 .search_term em").text("#{decoded_search_term}")

  watchDrawerToggle: ->
    $("header.top .drawer_toggle a").click (e) ->
      e.preventDefault()
      $('body').toggleClass('drawer_open')
      $('body').scrollTop 0

  watchSearchToggle: ->
    $(".search_holder .trigger .search").click (e) ->
      console.log 'yo, i clicked'
      e.preventDefault()

      $search_form = $(".search_holder")
      $search_box = $search_form.find("input")
      if $search_form.hasClass("expanded")
        console.log 'wtf'
        $search_form.removeClass("expanded")
      else
        console.log 'other no'
        $search_form.addClass("expanded")
        ElloWTFShared.resizeSearchBox()
        $search_box.focus()

  resizeSearchBox: ->
    $search_form = $(".search_holder")
    if $(window).width() < 1150 && $(window).width() > 719 && $search_form.hasClass('expanded')
      $search_form.find('span.form').removeAttr('style') # reset it in case previously fired

      left = $search_form.next().offset().left
      width = ($(window).width() - left - 30)
      $search_form.find('span.form').css('left',left).width(width)
    else if $(window).width() > 719 && $search_form.hasClass('expanded')
      # $search_form.removeClass("expanded") # might now need this anymore
      $search_form.find('span.form').removeAttr('style') # reset it in case previously fired

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
