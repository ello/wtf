root = exports ? this
root.ElloWTFPages =
  init: () ->
    ElloWTFPages.doAThing()

  initAjax: () ->
    ElloWTFPages.doAThing()
  
  doAThing: ->
    console.log 'thing!'
  
$(document).ready ->
  if $("body.pages").length
    ElloWTFPages.init()
