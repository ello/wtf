root = exports ? this
root.ElloWTFShared =
  init: () ->
    ElloWTFShared.doAThing()

  initAjax: () ->
    ElloWTFShared.doAThing()
  
  doAThing: ->
    console.log 'thing!'
  
$(document).ready ->
  ElloWTFShared.init()
