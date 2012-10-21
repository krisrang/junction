setupBlogHeaderScroll = ->
  $window = $(window)
  offsets = []
  targets = []
  activeTarget = null
  
  $posts = $('.blog-section article hgroup h3 a').each ->
    if @hash
      targets.push @hash
      offsets.push $(@hash).offset().top

  processScroll = (e) ->
    scrollTop = $window.scrollTop()

    for i in [0..offsets.length]
      if activeTarget != targets[i] && scrollTop > offsets[i] && (!offsets[i + 1] || scrollTop < offsets[i + 1])
        hgroup = $(activeTarget).find("hgroup")
        margintop = ''

        if hgroup.length
          margintop = '-' + ($(hgroup[0]).height() + 100) + 'px'

        $("h3 a[href=" + activeTarget + "]").removeClass("active").css({
          position: "absolute"
          top: "auto"
          'margin-top': margintop
        })

        activeTarget = targets[i]
        $("h3 a[href=" + activeTarget + "]").attr('style', '').addClass("active")

      if activeTarget && activeTarget != targets[i] && scrollTop + 50 >= offsets[i] && (!offsets[i + 1] || scrollTop + 50 <= offsets[i + 1])
        $("h3 a[href=" + activeTarget + "]")
          .removeClass("active")
          .css({
              position: "absolute"
              top: ($(activeTarget).outerHeight(true) + $(activeTarget).offset().top - 50) + "px"
              bottom: "auto"
          })

      if activeTarget == targets[i] && scrollTop > offsets[i] - 50  && (!offsets[i + 1] || scrollTop <= offsets[i + 1] - 50)
        if !$("h3 a[href=" + activeTarget + "]").hasClass("active")
          $("h3 a[href=" + activeTarget + "]").attr('style', '').addClass("active")

  $posts.click (e) ->
    if !@hash
      return

    $('html, body').stop().animate({scrollTop: $(@hash).offset().top}, 500, 'linear')

    processScroll()
    e.preventDefault()

  $window.scroll(processScroll).trigger("scroll")

$ ->
  $('#mobile-nav-btn').click ->
     $('.main-section').toggleClass 'nav-opened'

  if typeof window.matchMedia != 'undefined'
    mediaQuery = window.matchMedia "(max-width:799px)"
    if mediaQuery.matches
      isMobileView = true

  if !isMobileView && $('.blog-section article hgroup').length > 0
    setTimeout setupBlogHeaderScroll, 1000

    $('.blog-section article hgroup').each (i, e) ->
      $(e).find('h3 a').css({
         'margin-top': '-' + ($(e).height() + 100) + 'px' 
      }).addClass('adjusted')
