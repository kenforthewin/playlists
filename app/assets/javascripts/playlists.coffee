# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.submitPlaylist = () ->
  form = $('#playlist-form')
  form_data =  form.serialize()
  url = '/playlists?' + form_data
  playlist_id = form.data('playlist-id')
  $.post url, {playlist_id: playlist_id}, (data) ->
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
    delete_button = '<a href="#" onclick="return false;"><i class="material-icons delete-track" data-track-id=' + data.id.toString() + '>delete</i></a>'
    $('#track-list').append('<li>' + data.content + delete_button +  '</li>')




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

  $('body').on 'click', '.delete-track', ->
    track_id = $(this).data('track-id')
    li = $(this).closest('li')
    $.ajax
      url: '/tracks/' + track_id
      type: 'DELETE'
      success: ->
        li.remove()

  $('#playlist-show').steps(
    headerTag: 'h3'
    bodyTag: 'section'
    transitionEffect: 'fade'
    autoFocus: true
  )

  $('.playlist-play').click ->
    playlist_id = $(this).data('playlist-id')
    url = '/playlists/' + playlist_id.toString()
    $('#playlist-show').html('')
    $('#playlist-modal').openModal()

    setTimeout (->
      $.get url, (data) ->
       $.each data.tracks, (index, value) ->
         header = '<h3>Track ' + (index + 1).toString() + '</h3>'
         section = '<section>' + value.text_content + '</section>'

         $('#playlist-show').append header
         $('#playlist-show').append section

       setTimeout (->
         $('#playlist-show').steps
           headerTag: 'h3'
           bodyTag: 'section'
           transitionEffect: 'fade'
           autoFocus: true
           onFinished: ->
            $('#playlist-modal').closeModal()
       ), 50
    ), 50
#
#  $('.playlist-star').click ->
#    playlist_id = $(this).data('playlist-id')
#    url = '/playlists/' + playlist_id.toString() + '/upvote'
#    voted_for = $(this).data('voted-for')
#    vote_value = $(this).data('')
#    $.post url
#    if voted_for




