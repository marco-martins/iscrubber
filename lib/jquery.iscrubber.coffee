###
  jQuery iScrubber plugin 1.2.0

  @preserve
  Created by Marco Martins
  https://github.com/skarface/iscrubber.git
###

$.fn.iscrubber = (customOptions) ->

  _direction =
    horizontal: 'horizontal'
    vertical: 'vertical'
    ### combined works either horizontal or vertical, depending on the direction from where the mouse entered the element ###
    combined: 'combined'

  $.fn.iscrubber.defaultOptions =
    showItem: 1
    leaveToFirst: true
    direction: _direction.horizontal

  ### Set the options ###
  options = $.extend({}, $.fn.iscrubber.defaultOptions, customOptions)

  ### Set starting active direction. This gets changed only by the combined option. ###
  activeDirection = options.direction

  ### scrub function ###
  scrub = (elements, itemToShow) ->
    elements.css('display', 'none')
    $(elements[itemToShow - 1]).css('display', 'block')

  this.each ->
    $this = $(this)

    return if $this.data('iscrubber-enabled')
    $this.data('iscrubber-enabled', true)

    ### get elements ###
    elements = $this.find('li')

    ### set correct width from children and add minimal css require ###
    width = elements.first().width()
    height = elements.first().height()
    $this.width(width).height(height).css('padding', 0)

    numberOfChildren = $this.children().length

    ### get trigger size => (scrubber size / number of children) ###
    horizontalTrigger = width / numberOfChildren
    verticalTrigger = height / numberOfChildren

    ### show first element ###
    scrub(elements, options.showItem)

    ### state variables for combined mode ###
    [lastX, lastY, originX, originY, directionX, directionY] = [null, null, null, null, true, true]

    ### bind event when mouse moves over scrubber ###
    $this.on 'mousemove.iscrubber', (e) ->
      if activeDirection is _direction.combined
        ### starting direction depends on the side from which the mouse entered the element ###
        horizontalDistanceToEdge = Math.min(Math.abs(e.pageX - $this.offset().left), Math.abs(e.pageX - $this.offset().left - width))
        verticalDistanceToEdge = Math.min(Math.abs(e.pageY - $this.offset().top), Math.abs(e.pageY - $this.offset().top - height))

        if (horizontalDistanceToEdge < verticalDistanceToEdge)
          activeDirection = _direction.horizontal
        else
          activeDirection = _direction.vertical

        [lastX, lastY, originX, originY] = [e.pageX, e.pageY, e.pageX, e.pageY]

      if options.direction is _direction.combined
        ### allow to change direction in between, if the user starts moving significantly in the opposite direction ###
        if activeDirection is _direction.horizontal and Math.abs(e.pageY - originY) > height * 0.25
          activeDirection = _direction.vertical
          [originX, originY] = [e.pageX, e.pageY]

        else if activeDirection is _direction.vertical and Math.abs(e.pageX - originX) > width * 0.25
          activeDirection = _direction.horizontal
          [originX, originY] = [e.pageX, e.pageY]

        ### determine which direction the user is moving right now ###
        [newDirectionX, newDirectionY] = [e.pageX > lastX, e.pageY > lastY]

        ### change origin when user reverses mouse movement direction ###
        originX = e.pageX if newDirectionX isnt directionX
        originY = e.pageY if newDirectionY isnt directionY

        ### save for next frame ###
        [lastX, lastY] = [e.pageX, e.pageY]
        [directionX, directionY] = [newDirectionX, newDirectionY]

      ### get the index of image to display on top ###
      switch activeDirection
        when _direction.horizontal
          index = Math.ceil((e.pageX - $this.offset().left) / horizontalTrigger)
        when _direction.vertical
          index = Math.ceil((e.pageY - $this.offset().top) / verticalTrigger)

      index = Math.min(Math.max(index, 1), numberOfChildren)
      scrub(elements, index)

    $this.on 'mouseleave.iscrubber', ->
      scrub(elements, options.showItem) if options.leaveToFirst is true

      activeDirection = _direction.combined if options.direction is _direction.combined

