// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function upcResponse(json)
{
  if(json && json['asin']) {
    $('movie_asin').value   = json['asin'];
    $('movie_title').value  = json['title'];
    $('movie_format').value = json['type'];
    $('img_holder').appendChild(new Element('img', { 'src': json['image'] }));
    $('movie_image').value = json['image'];
    $('movie_image_link').value  = json['link'];
    $('movie_thumbnail').value  = json['thumbnail'];
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