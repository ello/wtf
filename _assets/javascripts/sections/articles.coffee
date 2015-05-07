root = exports ? this
root.ElloWTFArticles =
  init: () ->
    ElloWTFArticles.setUpVideo()
  
  setUpVideo: ->
    curServices = [
      # window.embetter.services.mixcloud
      window.embetter.services.youtube
      window.embetter.services.vimeo
      # window.embetter.services.soundcloud
      # window.embetter.services.instagram
      # window.embetter.services.dailymotion
      # window.embetter.services.codepen
    ]

    video_link = $('.post_content').data('video-link')
    unless typeof video_link == 'undefined' || video_link == ""
      # make the box 16x9 while we wait for the embed
      $embed_box = $('#video_embed')
      width = $embed_box.width()
      height = width * 9 / 16
      $embed_box.height(height)

      # grab/create the embed
      embed_box = document.getElementById('video_embed')
      window.embetter.utils.buildPlayerFromServiceURL(embed_box, video_link, curServices)
      setTimeout ->
        $embed_box.removeAttr('style')
      , 1000
  
$(document).ready ->
  if $("body.article").length
    ElloWTFArticles.init()
