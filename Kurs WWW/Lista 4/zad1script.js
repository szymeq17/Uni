$("#input").keyup(() => {
  let match = $("#input").val();
  $("#items").removeClass("gray");
  $( "li" ).each(function() {
    $(this).html(function(_, html) {
      return html.replace('<span class="yellow">', '');})
      $(this).html(function(_, html) {
        return html.replace('</span>', '');})})
  if(match.length >= 3) {
    $("#items").addClass("gray");
    $( "li" ).each(function() {
      $(this).html(function(_, html) {
        return html.replace(match, '<span class="yellow">' + match + '</span>');
})
});
    }
});
