root = exports ? this
root.ElloWTFSearch =
  init: () ->
    ElloWTFSearch.initSearch()

  initAjax: () ->
    ElloWTFSearch.initSearch()
  
  initSearch: ->
    $.getJSON('/wtf/json/posts.json').done (data) ->
      posts = data

      console.log posts
 
      index = lunr ->
        @field 'title', boost: 10
        @field 'body'
        @field 'excerpt'
        @ref 'id'
        return

      posts.forEach (post) ->
        index.add post
        return

      results = index.search('created')

      console.log results

      post_id = results[0].ref
      console.log post_id

      post = $.grep posts, (e) ->
        e.id == post_id

      console.log post[0].excerpt


  
  
$(document).ready ->
  if $("body.search").length
    ElloWTFSearch.init()
