$(document).ready(function() {
    $.getJSON('tvn24.json', function (data) {
        for (let i = 0; i < 5; i++) {
            let title = Mustache.render(`{{rss.channel.item.${i}.title}}`,data);
            let source = "<a href='"+ Mustache.render(`{{rss.channel.item.${i}.link}}`, data) + "'" + " target='_blank'>"
            let description = Mustache.render(`{{{rss.channel.item.${i}.description.__cdata}}}`, data);
            addToTable($("#articles"), title, description, source);
        }
    });

    function addToTable(table, title, description, source){
        table.append(
            "<tr><td>"+ title + "</td>" +
            "<td>" + description + "</td>" +
            "<td>" + source + "LINK</a></td></tr>");
    }
});
