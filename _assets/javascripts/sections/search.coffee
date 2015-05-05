root = exports ? this
root.ElloWTFSearch =
  init: () ->
    ElloWTFSearch.initSearch()

  initAjax: () ->
    ElloWTFSearch.initSearch()
  
  initSearch: ->
    console.log 'thing!'
  
$(document).ready ->
  if $("body.search").length
    ElloWTFSearch.init()
