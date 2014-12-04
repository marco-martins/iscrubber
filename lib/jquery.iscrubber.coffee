###
  jQuery iScrubber plugin 1.1.0
  
  @preserve
  Created by Marco Martins
  https://github.com/skarface/iscrubber.git
###

(($) ->

  $.fn.iscrubber = (customOptions) ->

    $.fn.iscrubber.defaultOptions =
      showItem: 1
      leaveToFirst: true
      additionalScrubKnobs: false

    ### Set the options ###
    options = $.extend({}, $.fn.iscrubber.defaultOptions, customOptions)

    ### scrub function ###
    scrub = (elements, itemToShow) ->
      if options.hideWithClass
        elements.addClass(options.hideWithClass)
        $(elements[itemToShow - 1]).removeClass(options.hideWithClass)
      else
        elements.css('display', 'none')
        $(elements[itemToShow - 1]).css('display', 'block')

    this.each ->
      $scrubberlist = $(this)

      return if $scrubberlist.data('iscrubber-enabled')
      $scrubberlist.data('iscrubber-enabled', true)

      ### get elements ###
      elements = $scrubberlist.find('li')

      ### set correct width from children and add minimal css require ###
      width = elements.first().width()
      $scrubberlist.width(width).css('padding', 0)

      ### get trigger width => (scrubber width / number of children) ###
      trigger = width / $scrubberlist.children().length

      ### show first element ###
      scrub(elements, options.showItem)

      ### bind event when mouse moves over scrubber ###
      $scrubberlist.on 'mousemove.iscrubber', (e) ->
        ### get x mouse position ###
        x = e.pageX - $scrubberlist.offset().left

        ### get the index of image to display on top ###
        index = Math.ceil(x/trigger)
        index = 1 if index == 0
        if ((index + 1) > elements.length)
          index = elements.length
        scrub(elements, index)

      ### bind event when mouse leaves scrubber ###
      $scrubberlist.on 'mouseleave.iscrubber', ->
        scrub(elements, options.showItem) if options.leaveToFirst is true

      if options.additionalScrubKnobs
        scrubber_data_id = $scrubberlist.data('scrubber')
        $knobs = $('html').find('a[data-scrubber="' + scrubber_data_id + '"]')
        $knobs.each ->
          $knob = $(this)
          k_width = $knob.width()
          k_trigger = k_width / $scrubberlist.children().length
          $knob.on 'mousemove.iscrubber', (e) ->
            k_x = e.pageX - $knob.offset().left
            k_index = Math.ceil(k_x/k_trigger)
            k_index = 1 if k_index == 0
            if ((k_index + 1) > elements.length)
              k_index = elements.length
            scrub(elements, k_index)
          $knob.on 'mouseleave.iscrubber', ->
            scrub(elements, options.showItem) if options.leaveToFirst is true

)(jQuery)
