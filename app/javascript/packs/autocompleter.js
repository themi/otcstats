
  function Autocompleter(element, options) {
    this.$element = $(element);
    this.options = $.extend({}, Autocompleter.defaults, options);
    this.$menu = $(options.menu);
    this.listen();
  };

  Autocompleter.defaults = {
    menu: '<ul class="autocomplete dropdown-menu" role="listbox"></ul>',
    item: '<li><a class="dropdown-item" href="#" role="option"></a></li>',
  };

  Autocompleter.prototype = {

    constructor: Autocompleter,

    listen: function () {
      this.$element
        .on('focus',    $.proxy(this.focus, this))
        .on('blur',     $.proxy(this.blur, this))
        .on('keypress', $.proxy(this.keypress, this))
        .on('propertychange input',    $.proxy(this.input, this))
        .on('keyup',    $.proxy(this.keyup, this));

      if (this.eventSupported('keydown')) {
        this.$element.on('keydown', $.proxy(this.keydown, this));
      }

      this.$menu
        .on('click', $.proxy(this.click, this))
        .on('mouseenter', 'li', $.proxy(this.mouseenter, this))
        .on('mouseleave', 'li', $.proxy(this.mouseleave, this))
        .on('mousedown', $.proxy(this.mousedown,this));
    },
  };

// var Autocompleter = {

//   self = this
//   element = $( element ),
//   menu = $( menu ),
//   value = this.$element.val() || this.$element.text(),

//   initialize: function( element, menu, options ) {
//     self.element = $( element );
//     self.menu = $( menu );
//     self.options = options;
//   },

//   fetch_from_url: function() {

//     $.getJSON( self.url, function( data ) {
//       var items = [];
//       $.each( data, function( key, val ) {
//         items.push( "<li id='" + key + "'>" + val + "</li>" );
//       });

//       $( "<ul/>", {
//         "class": "my-new-list",
//         html: items.join( "" )
//       }).appendTo( "body" );
//     });

//   },

// };





// var p = $( "p" ).first();
// var position = p.position();
// $( "p" ).last().text( "left: " + position.left + ", top: " + position.top );


// $( "*", document.body ).click(function( event ) {
//   var offset = $( this ).offset();
//   event.stopPropagation();
//   $( "#result" ).text( this.tagName +
//     " coords ( " + offset.left + ", " + offset.top + " )" );
// });
