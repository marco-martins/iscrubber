iScrubber
=========

Jquery plugin mimics iPhoto's picture scrubbing feature.

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

* Add this line to your css

`````css
  ul.scrubber li {display: none;}
`````

* You need add Jquery and iScrubber libs

`````html
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
  <script src="lib/jquery.iscrubber.min.js"></script>
`````

* To initialize the plugin

`````javascript
  $(".scrubber").iscrubber();
`````

* Default options, you can change it in initializer

`````javascript
  $(".scrubber").iscrubber({
    showItem: 1, // the element (li) it will be show first
    leaveToFirst: true // come back the the first element when mouse leave scrubber
  });
`````
