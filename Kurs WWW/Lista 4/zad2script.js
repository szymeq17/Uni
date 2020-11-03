

var adverbs = ["bezmyślnie", "arogancko", "chamsko", "cicho", "dostojnie",
"dosadnie", "fatalnie", "finezyjnie", "energicznie", "marudnie"];
var verbs = ["poszedł", "złapał", "powiedział", "milczał", "krzyczał",
"skakał", "leciał", "śpiewał", "pił", "jadł"];
var adjectives = ["fajną", "spoko", "piękną", "paskudną", "paskudne",
"śmierdzące", "zepsute", "pyszne", "przerażające", "głupie"];
var nouns = ["piwo", "wódkę", "dziewczynę", "chłopaka", "prezydenta",
"koronawirusa", "Polskę", "burgera", "kanapkę", "mleko"];

function getRandomIntInclusive(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

$(document).ready(function() {
for(i=0; i<adverbs.length; i++) {
  $("#words").append("<tr><td>" + adverbs[i] + "</td><td>" + verbs[i] +
  "</td><td>" + adjectives[i] + "</td><td>" + nouns[i] + "</td></tr>");
}

$("#gen-btn").click(function() {
  let w1 = getRandomIntInclusive(0, verbs.length-1);
  let w2 = getRandomIntInclusive(0, verbs.length-1);
  let w3 = getRandomIntInclusive(0, verbs.length-1);
  let w4 = getRandomIntInclusive(0, verbs.length-1);
  let word = adverbs[w1] + " " + verbs[w2] + " " + adjectives[w3] + " "
  + nouns[w4] + ".";
  let first = word.charAt(0).toUpperCase();
  word = first + word.substring(1);
  $("#result").html(word)
})
})
