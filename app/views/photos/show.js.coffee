$("#selectedPhoto").fadeOut 'normal', -> 
  $("#selectedPhoto").html("<%= escape_javascript(render(@photo)) %>")
  $("#selectedPhoto").fadeIn('normal')
