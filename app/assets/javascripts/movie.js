// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var movieTemplate = JST['templates/movie'];

var slickOptions = {
  // autoplay: true,
  slidesToShow: 3,
  infinite: true,
  centerMode: true
};

var search = function(event) {
  var filter = $('[data-role="search"]').val();

  if(!filter) {
    return;
  }

  window.history.pushState(null, null, '/?filter=' + encodeURIComponent(filter));

  $.getJSON("/", { filter: filter }, function(response) {
    var movies = response.map(function(movie) {
      return movieTemplate({ movie: movie });
    });

    $('.movies').slick('unslick');
    $('.movies').html(movies);
    $('.movies').slick(slickOptions);
  });
};

$(document).click(function(event) {
  if ($(event.target).data('role') === 'submit') {
    search(event);
  }
})

$(document).keydown(function(event) {
  if (event.keyCode === 13 && $(event.target).data('role') === 'search') {
    search(event);
  }
});

document.addEventListener("turbolinks:load", function() {
  $('.movies').slick(slickOptions);
})

window.addEventListener("popstate", function(e) {
  window.location.reload();
});