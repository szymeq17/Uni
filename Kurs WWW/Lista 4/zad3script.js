function showMarked() {
  let marked = "Zaznaczone: ";
  $("img").each(function() {
    if($(this).data("marked")) {
      marked += $(this).attr("id") + ", ";
    }
  })
  marked = marked.substring(0, marked.length-2);
  $("#log").text(marked);
}

function selectAll() {
  $("img").each(function() {
    $("img").data("marked", true);
    $(this).css("border-color", "#00A1FF");
  })
  showMarked();
}

function unselectAll() {
  $("img").each(function() {
    $("img").data("marked", false);
    $(this).css("border-color", "black");
  })
  $("#log").text("Zaznaczone: ")
}

$(document).ready(function() {

$("img").each(function() {
  $(this).data("marked", false);
})

$("img").each(function() {
  $(this).click(function() {
    if($(this).data("marked")) {
      $(this).data("marked", false);
      $(this).css("border-color", "black");
    }
    else {
      $(this).data("marked", true);
      $(this).css("border-color", "#00A1FF");
    }
    showMarked();
  });
})
$("#select-all").click(selectAll);
$("#unselect-all").click(unselectAll);
})
