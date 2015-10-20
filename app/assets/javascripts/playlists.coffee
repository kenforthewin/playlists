# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.submitPlaylist = () ->
  form = $('#playlist-form')
  form_data =  form.serialize()
  url = '/playlists?' + form_data
  $.post url, form_data, (data) ->
    form.data('playlist-id', data)
    $('#track-form').data('playlist-id', data)
  true

window.submitTrack = () ->
  form = $('#track-form')
  form_data = form.serialize()
  url = '/tracks?' +'playlist_id=' + form.data('playlist-id')
  content = $('#track-content').val()
  $.post url, {content: content}, (data) ->
    $('#track-content').val('')
    $('#track-list').append('<li>' + data.content + '</li>')



$ ->
  $('#addTrack').on 'click',  ->
    submitTrack()

  playlistForm = $('#playlist-form')



  $('#playlist-setup').steps(
    headerTag: 'h3'
    bodyTag: 'section'
    transitionEffect: 'fade'
    autoFocus: true
    onStepChanging: (event, currentIndex, newIndex) ->
      if currentIndex == 0
        submitPlaylist()
      else
        true

  )

  $('#track-form').submit ->
    submitTrack()
    false


