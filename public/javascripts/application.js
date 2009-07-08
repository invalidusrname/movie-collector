// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function upcResponse(json) {
  if(json && json['asin']) {
    $('movie_asin').value   = json['asin'];
    $('movie_title').value  = json['title'];
    $('movie_format').value = json['format'];
    $('img_holder').appendChild(new Element('img', { 'src': json['image'] }));
    $('movie_image').value = json['image'];
    $('movie_image_link').value  = json['image_link'];
    $('movie_thumbnail').value  = json['thumbnail'];
  }
}

function userUpcResponse(json) {
  if(json && json['title']) {

    updateMovieFields(json['title'], json['upc'], json['format']);

    removeImages();

    $('img_holder').appendChild(new Element('img', { 'src': json['image'] }));
  }
}

function userTitleResponse(json) {
  if(json) {
    elements = $('img_holder').childElements();

    removeImages();
    
    $('img_holder').appendChild(new Element('ul', { 'id': 'aaa'}));
    
    json.each(function(s) {
      json = Object.toJSON(s);
      json = json.evalJSON();
      e = new Element('li');
      onclick = "updateMovieFields('" + escape(json['title']) + "','" +  json['upc'] + "','" + json['format'] + "');"
      e.appendChild(new Element('img', { 'src': json['thumbnail'], 'onclick':  onclick}));
      $('aaa').appendChild(e);
    });
  }
}

function updateMovieFields(title, upc, format) {
  $('movie_title').value  = unescape(title);
  $('movie_upc').value    = upc;
  $('movie_format').value = format;
}

function removeImages() {
  elements = $('img_holder').childElements();

  if(elements) {
    elements.each(function(s) {
      s.remove();
    });
  }
}

function fbNotLoggedIn() {
  $('test').innerHTML =
     '<fb:login-button></fb:login-button>'
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