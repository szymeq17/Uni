function removeImg(source) {
  let start = source.indexOf("<img");
  let end = source.indexOf("/>");
  let toRemove = source.slice(start, end+2);
  source = source.replace(toRemove, "");
  return source;
}

function search(){
  $("#search-results").html("");
  $.get("https://tvn24.pl/najnowsze.xml", function(data) {
    $("#search-results").append("<tr>" +
        "<th>Tytuł</th>" +
        "<th>Opis</th>" +
        "<th>Link</th>" +
        "</tr>")
    for (const element of $(data).xpath("/rss/channel/item")){
      let description = removeImg($(element).xpath("./description/text()")[1].data);
      if (description.includes($("#search-phrase").val()))
      {
        let source = ($(element).xpath("./link/text()")[0].data);
        let title = ($(element).xpath("./title/text()")[0].data);
        $("#search-results").append( "<tr>" +
            "<td>" + title + "</td>" +
            "<td>" + description + "</td>" +
            "<td><a target='_blank' href='" + source + "'>LINK</a></td>" + "</tr>" );
      }

    }
  })
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
  });
})
  $("#search-btn").on("click", search);
});
