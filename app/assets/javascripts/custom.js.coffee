
jQuery -> 
   $('.best_in_place').best_in_place()

jQuery ->
  $(document).scroll ->
    if not $('.subnav').attr('data-top')
      if $('.subnav').hasClass('subnav-fixed') then return
      offset = $('.subnav').offset()
      $('.subnav').attr('data-top', offset.top)

    if $('.subnav').attr('data-top') - $('.subnav').outerHeight() <= $(this).scrollTop()
      $('.subnav').addClass('subnav-fixed')
    else
      $('.subnav').removeClass('subnav-fixed') 

