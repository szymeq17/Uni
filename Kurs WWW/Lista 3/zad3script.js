function moveSquare(i) {
  let square = document.getElementById("square"+i);
  console.log(i);
  let style = window.getComputedStyle(square);
  if(style.getPropertyValue('top') == "300px") {
    square.style.top = "250px";
  }
  else {
    square.style.top = "300px";
  }
}

setInterval(() => {moveSquare(1);}, 2500);
setTimeout(() => {setInterval(() => {moveSquare(2);}, 2500);}, 500);
setTimeout(() => {setInterval(() => {moveSquare(3);}, 2500);}, 1000);
setTimeout(() => {setInterval(() => {moveSquare(4);}, 2500);}, 1500);
setTimeout(() => {setInterval(() => {moveSquare(5);}, 2500);}, 2000);
