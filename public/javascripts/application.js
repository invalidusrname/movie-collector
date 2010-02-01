// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function myOnRate(element, memo) {
  memo.id = element.id.split("_", 2)[1];
  new Ajax.Request('/users_movies/add_rating', {
    parameters: memo,
    onComplete: function(xhr) {
      // optional callback
    }
  });
}

function searchTitle(event) {
  var title = this.value;

  if (title.length < 3) {
    return false;
  }

  return $.getJSON('/movies/amazon_search', {title: title}, function(json) {
    removeImages();
    $('#img_holder').append('<ul></ul>');

    jQuery.each(json, function(i, data) {
      var img = "<img src='" + data.thumbnail  + "' title='" + data.title +
                  "' upc='" + data.upc + "' format='" + data.format + "' />";
      $('#img_holder ul').append('<li>' + img + '</li');
    });
  });
}

function upcResponse(json) {
  if(json && json['asin']) {
    $('#movie_asin').value   = json['asin'];
    $('#movie_title').value  = json['title'];
    $('#movie_format').value = json['format'];
    $('#img_holder').append(new Element('img', { 'src': json['image'] }));
    $('#movie_image').value = json['image'];
    $('#movie_image_link').value  = json['image_link'];
    $('#movie_thumbnail').value  = json['thumbnail'];
  }
}

function userUpcResponse(json) {
  if(json && json['title']) {

    updateMovieFields(json['title'], json['upc'], json['format']);

    removeImages();

    $('#img_holder').append(new Element('img', { 'src': json['image'] }));
  }
}

function imageClick(event) {
  if(event.target && event.target.tagName == 'IMG') {
    var img = event.target;
    $('#users_movie_movie_attributes_title').attr('value', unescape(img.title));
    $('#users_movie_movie_attributes_upc').attr('value', img.getAttribute('upc'));
    $('#users_movie_movie_attributes_format').attr('value', img.getAttribute('format'));
  }
}

function updateMovieFields(title, upc, format) {
  $('users_movie_movie_attributes_title').value  = unescape(title);
  $('users_movie_movie_attributes_upc').value    = upc;
  $('users_movie_movie_attributes_format').value = format;
}

function removeImages() {
  var tmp = $('#img_holder');
  if (tmp) {
    tmp.empty();
  }
}

function fbNotLoggedIn() {
  $('test').innerHTML = '<fb:login-button></fb:login-button>';
  FB.XFBML.Host.parseDomTree();
}

function fbLoggedIn() {
  $('test').innerHTML =
     '<fb:profile-pic uid="loggedinuser" facebook-logo="true"></fb:profile-pic>'
    + "Welcome, <fb:name uid='loggedinuser' useyou='false'></fb:name>";
  FB.XFBML.Host.parseDomTree();
}

function submitMovie(form){
  if(form.publish_to_facebook.value == 1) {
    templates = { "title": form.movie_title.value, "url": form.amazon_page_url.value,
    "images": [{ "src": form.amazon_image_url.value, "href": form.amazon_page_url.value}]
    };
    FB.Connect.showFeedDialog(90781317571, templates);
  }
}

$(function(){
  $('ul.sf-menu').superfish();

  var tabContainers = $('div.tabs > div');

  // if(tabContainers) {
    // tabContainers.hide().filter(':first').show();
    // $('#topnav a').click(function () {
    //   tabContainers.hide();
    //   tabContainers.filter(this.hash).show();
    //   $('div.tabs ul.tabNavigation a').removeClass('selected');
    //   $(this).addClass('selected');
    //   return false;
    // }).filter(':first').click();
  // }
});

$(function () {
  var tabContainers = $('div.loginpane > div');
  tabContainers.hide().filter(':one').show();

  $('div.loginpane ul.loginNavigation a').click(function () {
    tabContainers.hide();
    tabContainers.filter(this.hash).show();
    $('div.loginpane ul.loginNavigation a').removeClass('selected');
    $(this).addClass('selected');
    return false;
    }).filter(':one').click();
});
