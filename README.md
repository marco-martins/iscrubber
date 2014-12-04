iScrubber
=========

jQuery plugin that mimics iPhoto's picture scrubbing feature.

[See demo page](http://skarface.github.io/iscrubber/)

### Minimal Setup

* Create the element structure with pictures

`````html
  <ul class="scrubber">
    <li><img src="images/image1.png"></li>
    <li><img src="images/image2.png"></li>
    <li><img src="images/image3.png"></li>
    <li><img src="images/image4.png"></li>
  </ul>
`````

* Add this line to your CSS

`````css
  ul.scrubber li {display: none;}
`````

* Add jQuery and iScrubber libs

`````html
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
  <script src="lib/jquery.iscrubber.min.js"></script>
`````

* Initialize the plugin

`````javascript
  $(".scrubber").iscrubber();
`````

* Customize it

`````javascript
  $(".scrubber").iscrubber({
    showItem: 1, // the element (li) to show first; 1 based index
    leaveToFirst: true // come back the the first element when mouse leaves scrubbing area
    hideWithClass: "hide" // use the specified class or set to false to use display:none
    additionalScrubKnobs: false // if true, find any links in the page that have the same
                                // data-scrubber value as the scrubber ul, and scrub images
                                // when the mouse hovers over them.
  });
`````
