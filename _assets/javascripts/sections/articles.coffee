root = exports ? this
root.ElloWTFArticles =
  init: () ->
    ElloWTFArticles.setUpVideo()
    window.embetter.reloadPlayers()

  setUpVideo: ->
    curServices = [
      window.embetter.services.bandcamp
      window.embetter.services.codepen
      window.embetter.services.dailymotion
      window.embetter.services.mixcloud
      window.embetter.services.soundcloud
      window.embetter.services.ustream
      window.embetter.services.vimeo
      window.embetter.services.youtube
      # window.embetter.services.instagram
    ]

    window.embetter.reloadPlayers = (el=document.body) ->
      window.embetter.utils.disposeDetachedPlayers()
      window.embetter.utils.initMediaPlayers(el, curServices)

$(document).ready ->
  if $("body.article").length
    ElloWTFArticles.init()
