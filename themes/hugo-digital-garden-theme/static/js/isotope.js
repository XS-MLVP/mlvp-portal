// Solution working for a multiple buttons checked at a time
// https://codepen.io/desandro/pen/JGKyrY
//
var $blogposts = $('#blogposts');

function setEqualHeight() {
    var tallest = 0;
    var $cards = $blogposts.find('.card');
    $cards.css('min-height', '0'); // reset
    $cards.each(function() {
        if ($(this).outerHeight() > tallest) {
            tallest = $(this).outerHeight();
        }
    });
    $cards.css('min-height', tallest + 'px');
}

// Set heights before initializing Isotope
setEqualHeight();

$blogposts.isotope({
  itemSelector: '.col',
  layoutMode: 'fitRows'
});

// Update on resize
$(window).on('resize', function() {
    setEqualHeight();
    $blogposts.isotope('layout');
});

var $checkboxes = $('#filters input');

$checkboxes.change( function() {
    var inclusives = [];
    $checkboxes.each( function( i, elem ) {
      if ( elem.checked ) {
        inclusives.push( elem.id );
      }
    });
    var filterValue = inclusives.length ? inclusives.join(', ') : '*';
    $blogposts.isotope({ filter: filterValue })
});

// Solution working for a single button checked at a time
// https://codepen.io/desandro/pen/lxzDA
//
// var $blogposts = $('#blogposts'); 
// $blogposts.isotope({
//   itemSelector : '.col'
// }); 
// $('#filters').on( 'click', 'button', function() {
//     var selector = $(this).attr('data-filter');
//     $blogposts.isotope({ filter: selector });
//     return false;
// });
// $('.button-group').each( function( i, buttonGroup ) {
//     var $buttonGroup = $( buttonGroup );
//     $buttonGroup.on( 'click', 'button', function() {
//       $buttonGroup.find('.is-checked').removeClass('is-checked');
//       $( this ).addClass('is-checked');
//     });
// });