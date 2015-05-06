root = exports ? this
root.ElloWTFSearch =
  search_index: ''
  posts: ''
  init: () ->
    # don't do anything else before the posts are loaded and the index is created
    ElloWTFSearch.initSearch()

  # initAjax: () ->
  #   ElloWTFSearch.initSearch()
  
  initSearch: ->
    $.getJSON('/wtf/json/posts.json').done (data) ->
      ElloWTFSearch.posts = data

      # now that we have the posts, create the index
      ElloWTFSearch.createIndex()

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
      $('.content .results').html('')

  displayResults: (results) ->
    $('.content .results').html('')

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
      $result.find('.excerpt').text(post.excerpt)
      $result.show()
      # console.log $result

      # add the result to the page
      $('.content .results').append($result)    

  clearResults: ->
    $results_box = $('.content .results')
    $results_box.html('')
    $(".content h1 .search_term em").text("")
    $(".content h1.main").hide()
    $(".content h1.alt").show()
  
  
$(document).ready ->
  if $("body.search").length
    ElloWTFSearch.init()
