/*
 * jQuery iScrubber plugin 1.0.0
 *
 * Created by Marco Martins
 * https://github.com/skarface/iscrubber.git
 *
 */
(function() {

  $.fn.iscrubber = function(customOptions) {
    var options, scrub;
    $.fn.iscrubber.defaultOptions = {
      showItem: 1, // the element (li) will show first
      leaveToFirst: true // come back the the first element when mouse leave scrubber
    };

    // set the options
    options = $.extend({}, $.fn.iscrubber.defaultOptions, customOptions);

    // scrubber function
    scrub = function(elements, itemToShow) {
      elements.css('display', 'none');
      return $(elements[itemToShow - 1]).css('display', 'block');
    };
    return this.each(function() {
      var $this, elements, trigger, width;
      $this = $(this);

      // get elements
      elements = $this.find('li');

      // set correct width from children and add minimal css require
      width = elements.first().width();
      $this.width(width).css('padding', 0);

      // get trigger width => (scrubber width / number of children)
      trigger = width / $this.children().length;

      // show first element
      scrub(elements, options.showItem);

      // bind event when mouse moves over scrubber
      $this.mousemove(function(e) {
        var index, x;

        // get x mouse position
        x = e.pageX - $this.offset().left;
        index = Math.ceil(x / trigger);
        if (index === 0) {
          index = 1;
        }

        // get the index of li (image) to display on top
        return scrub(elements, index);
      });

      // bind event when mouse leaves scrubber
      return $this.mouseleave(function() {
        if (options.leaveToFirst === true) {
          return scrub(elements, options.showItem);
        }
      });
    });
  };

}).call(this);
