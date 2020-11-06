function removeImg(source) {
  let start = source.indexOf("<img");
  let end = source.indexOf("/>");
  let toRemove = source.slice(start, end+2);
  source = source.replace(toRemove, "");
  return source;
}

$(document).ready(function() {
$.get("https://tvn24.pl/najnowsze.xml", function(data) {
  let xml = data,
            xmlDoc = $.parseXML(xml),
            $xml = $( xmlDoc );
  let i=0;
  $(xml).find( "item" ).each(function () {
    if(i==5) {
      return 0;
    }
    i++;
    $("#articles").append( "<tr>" +
        "<td>" + $(this).find("title").text() + "</td>" +
        "<td>" + removeImg($(this).find("description").text()) + "</td>" +
        "<td><a target='_blank' href='" + $(this).find("link").text() + "'>LINK</a></td>" + "</tr>" );
  })
;
})
});
