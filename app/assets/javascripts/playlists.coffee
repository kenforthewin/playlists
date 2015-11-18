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
    $('#track-youtube-form').data('playlist-id', data)
    $('#track-tweet-form').data('playlist-id', data)
  true

window.submitTrack = () ->
  form = $('#track-form')
  form_data = form.serialize()
  url = '/tracks?' +'playlist_id=' + form.data('playlist-id')
  content = $('#track-content').val()
  $.post url, {content: content, content_type: 0}, (data) ->
    $('#track-content').val('')
    delete_button = '<a href="#" onclick="return false;"><i class="material-icons delete-track" data-track-id=' + data.id.toString() + '>delete</i></a>'
    $('#track-list').append('<li>' + data.content + delete_button +  '</li>')

window.submitYoutubeTrack = () ->
  form = $('#track-youtube-form')
  form_data = form.serialize()
  url = '/tracks?' +'playlist_id=' + form.data('playlist-id')

  content = $('#track-youtube-content').val()
  $.post url, {content: content, content_type: 1}, (data) ->
    $('#track-youtube-content').val('')
    delete_button = '<a href="#" onclick="return false;"><i class="material-icons delete-track" data-track-id=' + data.id.toString() + '>delete</i></a>'
    $('#track-list').append('<li class="track-youtube">' + data.content + delete_button + '</li>')

window.submitTweetTrack = () ->
  form = $('#track-tweet-form')
  form_data = form.serialize()
  url = '/tracks?' +'playlist_id=' + form.data('playlist-id')
  content = $('#track-tweet-content').val()
  $.post url, {content: content, content_type: 2}, (data) ->
    $('#track-tweet-content').val('')
    delete_button = '<a href="#" onclick="return false;"><i class="material-icons delete-track" data-track-id=' + data.id.toString() + '>delete</i></a>'
    $('#track-list').append('<li class="track-tweet">' + data.content + delete_button + '</li>')

$ ->
  $('#addTrack').on 'click',  ->
    submitTrack()

  $('#addYoutubeTrack').on 'click', ->
    submitYoutubeTrack()

  $('#addTweetTrack').on 'click', ->
    submitTweetTrack()

  playlistForm = $('#playlist-form')



  $('#playlist-setup').steps(
    headerTag: 'h3'
    bodyTag: 'section'
    transitionEffect: 'none'
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

  $('#track-youtube-form').submit ->
    submitYoutubeTrack()
    false

  $('#track-tweet-form').submit ->
    submitTweetTrack()
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
    url = '/playlists/' + playlist_id.toString() + '.json'
    $('#playlist-show').html('')
    $('#playlist-modal').openModal()

    setTimeout (->
      $.get url, (data) ->
       $.each data.tracks, (index, value) ->
         content = '<tr><td>' + (index  + 1).toString() + '</td>' + '<td><p>' + value.text_content + '</p></td></tr>'

         $('#playlist-show').append content
    ), 50

  $('.playlist-star').click ->
    playlist_id = $(this).data('playlist-id')
    url = '/playlists/' + playlist_id.toString() + '/upvote'
    voted_for = $(this).data('voted-for')
    vote_value = $(this).data('vote-value')
    signed_in = $(this).data('signed-in')
    $.post url
    if voted_for
      $(this).data('voted-for', false)
      $(this).css('color', 'black')
      $(this).data('vote-value', vote_value - 1)
      $('.vote-value[data-playlist-id="' + playlist_id + '"]').html(vote_value - 1)
    else if signed_in
      $(this).data('voted-for', true)
      $(this).css('color', '#26a69a')
      $(this).data('vote-value', vote_value + 1)
      $('.vote-value[data-playlist-id="' + playlist_id + '"]').html(vote_value + 1)


  $('#track-form').hide()
  $('#track-youtube-form').hide()
  $('#track-tweet-form').hide()
  $('#add-youtube').click (e) ->
    e.preventDefault()

    $('#track-youtube-form').show()
    $('#track-form').hide()
    $('#track-tweet-form').hide()

  $('#add-text').click (e) ->
    e.preventDefault()

    $('#track-youtube-form').hide()
    $('#track-form').show()
    $('#track-tweet-form').hide()

  $('#add-tweet').click (e) ->
    e.preventDefault()

    $('#track-youtube-form').hide()
    $('#track-form').hide()
    $('#track-tweet-form').show()


  $('.track-number').click ->
    track_id = $(this).data('track-id')
    $('.track-content[data-track-id="' + track_id + '"]').toggle()