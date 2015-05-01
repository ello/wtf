root = exports ? this
root.ElloWTFArticles =
  init: () ->
    setTimeout ->
      ElloWTFArticles.setUpVideo()
    , 1000

  # initAjax: () ->
  #   ElloWTFArticles.doAThing()
  
  setUpVideo: ->
    curServices = [
      window.embetter.services.mixcloud
      window.embetter.services.youtube
      window.embetter.services.vimeo
      window.embetter.services.soundcloud
      window.embetter.services.instagram
      window.embetter.services.dailymotion
      window.embetter.services.codepen
    ]

    video_link = $('.post_content').data('video-link')
    console.log video_link
    unless typeof video_link == 'undefined' || video_link == ""
      embed_box = document.getElementById('video_embed')
      window.embetter.utils.buildPlayerFromServiceURL(embed_box, video_link, curServices)
  
$(document).ready ->
  if $("body.article").length
    ElloWTFArticles.init()
