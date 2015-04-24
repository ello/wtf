root = exports ? this
root.ElloWTFArticles =
  init: () ->
    ElloWTFArticles.doAThing()

  initAjax: () ->
    ElloWTFArticles.doAThing()
  
  doAThing: ->
    console.log 'thing!'
  
$(document).ready ->
  if $("body.articles").length
    ElloWTFArticles.init()
