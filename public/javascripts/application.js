// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function upcResponse(json)
{
  if(json && json['asin']) {
    $('movie_asin').value   = json['asin'];
    $('movie_title').value  = json['title'];
    $('movie_format').value = json['type'];
    // img = new Element('img', { 'src': json['img'], });
    // $('upc').appendChild(img);
  }
}