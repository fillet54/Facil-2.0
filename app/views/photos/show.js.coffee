$("#selectedPhoto").fadeOut 'normal', ->
  loadingTimer = setTimeout -> 
    $("#selectedPhotoContainer").spin() 
  , 100

  $("#selectedPhoto").html("<%= escape_javascript(render(@photo)) %>")
  $("#selectedPhoto > img").hide()
  $("#selectedPhoto > img").load ->
    clearTimeout loadingTimer
    $("#selectedPhotoContainer").spin false
    jQuery(this).fadeIn 'normal'
  $("#selectedPhoto").fadeIn 'normal'
