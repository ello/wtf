root = exports ? this
root.ElloWTFSearch =
  search_index: ''
  posts: ''
  init: () ->
    ElloWTFSearch.initSearch()

  # initAjax: () ->
  #   ElloWTFSearch.initSearch()
  
  initSearch: ->
    $.getJSON('/wtf/json/posts.json').done (data) ->
      ElloWTFSearch.posts = data

      console.log ElloWTFSearch.posts

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
    search_term = ElloWTFShared.getURLParameter("for")
    ElloWTFSearch.searchIndex()

  searchIndex: ->
    search_term = $(".search_holder .form input").val()
    results = ElloWTFSearch.search_index.search(search_term)

    console.log results

    post_id = results[0].ref
    console.log post_id

    post = $.grep ElloWTFSearch.posts, (e) ->
      e.id == post_id

    console.log post[0].excerpt


  
  
$(document).ready ->
  if $("body.search").length
    ElloWTFSearch.init()
