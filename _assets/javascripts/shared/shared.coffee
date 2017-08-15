root = exports ? this
root.ElloWTFShared =
  init: () ->
    ## resize stuff
    ElloWTFShared.checkMobile()
    ElloWTFShared.masterResizeListener()
    ## other shared functions
    ElloWTFShared.watchSearchHeader()
    ElloWTFShared.watchURLSearchTerms()
    ElloWTFShared.watchSearchToggle()
    ElloWTFShared.watchShareable()
    ElloWTFShared.registerView()

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

  masterResizeListener: ->
    if $('html.mobile, html.tablet').length > 0
      $(window).on "orientationchange", -> ElloWTFShared.updateOrientation()

    unless $('html.mobile').length or $('html.tablet').length
      $(window).smartresize ->
        # console.log 'resize!'
        ## orientation resize functions here

  watchSearchHeader: ->
    $search_form = $(".search-holder .form")
    $search_box = $search_form.find("input")

    $search_box.keyup $.debounce(( (e) ->
      # console.log $search_box.val()
      search_term = $search_box.val()
      if search_term != ""
        $search_form.removeClass("inactive")
        if search_term.length > 1
          ElloWTFSearch.searchIndex(search_term)
          $("#search_content h1 .search_term em").text("#{search_term}")
          $("#search_content h1.main").show()
          $("#search_content h1.alt").hide()
          ElloWTFSearch.updateSearchUrl(search_term)
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
      $(".search-holder").addClass("active")
    $search_box.on "focusout", ->
      $(".search-holder").removeClass("active")

    $search_form.find(".clear-search").click (e) ->
      e.preventDefault()
      $search_box.val("")
      $search_form.addClass("inactive")
      $search_box.focus()
      ElloWTFSearch.clearResults()

  watchURLSearchTerms: ->
    search_term = ElloWTFShared.getURLParameter("for")
    unless typeof search_term == "undefined" || search_term == ""
      decoded_search_term = decodeURIComponent(search_term).replace(/\+/g , " ")
      $(".search-holder .form input").val("#{decoded_search_term}")
      $(".search-holder .form").removeClass("inactive")
      $(".search-holder").addClass("expanded")
      $("header.top").addClass("search_open")
      $("#search_content h1 .search_term em").text("#{decoded_search_term}")

  watchSearchToggle: ->
    $(".search-holder .trigger .search").click (e) ->
      e.preventDefault()

      $search_form = $(".search-holder")
      $search_box = $search_form.find("input")
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

  watchShareable: ->
    $(document).on "click", ".shareable.widget a", (e) ->
      e.preventDefault()
      $('.shareable.modal').fadeIn(150)

    $(document).on "click", ".shareable.modal", (e) ->
      unless $(e.target).parents('.modal-content').length || $(e.target).hasClass('modal-content')
        $('.shareable.modal').fadeOut(150)

  registerView: ->
    post_token = String($('.page-header').data('credit-post-token'))
    if post_token != 'undefined'
      path = "/api/v2/post_views/?post_tokens=#{post_token}"

      $.ajax
        type: "GET"
        url: path
        processData: false
      .fail ->
        console.log("failure registering post view (token: #{post_token})")

$(document).ready ->
  ElloWTFShared.init()
