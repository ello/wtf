root = exports ? this
root.ElloWTFSearch =
  search_index: ''
  posts: ''
  init: () ->
    # don't do anything else before the posts are loaded and the index is created
    ElloWTFSearch.initSearch()
  
  initSearch: ->
    $.getJSON('/wtf/json/posts.json').done (data) ->
      ElloWTFSearch.posts = data

      # now that we have the posts, create the index
      ElloWTFSearch.createIndex()

      if $('body.search').length
        ElloWTFSearch.invokeSearch()

  createIndex: ->
    ElloWTFSearch.search_index = lunr ->
      @field 'title', boost: 10
      @field 'body'
      @ref 'id'
      return

    ElloWTFSearch.posts.forEach (post) ->
      ElloWTFSearch.search_index.add post
      return

    # make first query once index is created
    search_term = $(".search_holder .form input").val()
    ElloWTFSearch.searchIndex(search_term)

  searchIndex: (search_term) ->
    results = ElloWTFSearch.search_index.search(search_term)
    # console.log results

    unless typeof results == "undefined" || results.length == 0
      ElloWTFSearch.displayResults(results)
    else
      $('#search_content .results').html('')

  displayResults: (results) ->
    $('#search_content .results').html('')

    results.forEach (result) ->
      post_id = result.ref
      post_array = $.grep ElloWTFSearch.posts, (e) ->
        e.id == post_id
      post = post_array[0]

      # clone our example result to use as a template
      $result = $('.post.result.example').clone()

      # add our post data to our result
      $result.removeClass('example')
      $result.find('h2 a').text(post.title)
      $result.find('a').attr('title',post.title).attr('href',post.url)
      $result.find('.desktop_excerpt .excerpt').text(post.excerpt)
      $result.find('.mobile_excerpt .excerpt').text(post.excerpt_mobile)
      $result.show()
      # console.log $result

      # add the result to the page
      $('#search_content .results').append($result)    

  clearResults: ->
    $results_box = $('#search_content .results')
    $results_box.html('')
    $("#search_content h1 .search_term em").text("")
    $("#search_content h1.main").hide()
    $("#search_content h1.alt").show()
  
  invokeSearch: ->
    search_term = $(".search_holder .form input").val()

    $('#main_content').hide()
    $('#search_content').show()

    # console.log window.location

    if (history.pushState)      
      if search_term.length > 0
        search_term_encoded = "?for=#{encodeURIComponent(search_term).replace(/\+/g , " ")}"
      else
        search_term_encoded = ""
        ElloWTFSearch.clearResults()
      link = "#{window.location.origin}/wtf/search#{search_term_encoded}".replace("search/","").replace("searchsearch","search")
      base_title = $('body').data('site-title')
      title = "Search for: “#{search_term}” | #{base_title}"
      window.history.pushState(title, title, link)

      # console.log link
  
$(document).ready ->
  ElloWTFSearch.init()
