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

  displayResults: (results) ->
    console.log 'we have results!'
    post_id = results[0].ref
    console.log post_id

    post = $.grep ElloWTFSearch.posts, (e) ->
      e.id == post_id

    console.log post[0].excerpt

  clearResults: ->
    console.log 'clear the things!'
    $results_box = $('.content .results')
    $results_box.prepend('nothing to see here.')
  
  
$(document).ready ->
  if $("body.search").length
    ElloWTFSearch.init()
