class Auto {
  constructor(mark, models) {
    this.mark = mark;
    this.models = models;
  }
  addModel(modelName) {
    this.models.push(modelName);
  }
}

function removeOptions(selectElement) {
   var i, L = selectElement.options.length - 1;
   for(i = L; i >= 0; i--) {
      selectElement.remove(i);
   }
}

function showModels() {
  let name = markList.value;
  for(i=0; i<cars.length; i++) {
    if(name == cars[i].mark) {
      removeOptions(modelList);
      for(j=0; j<cars[i].models.length; j++) {
        let opt = document.createElement("option");
        opt.text = cars[i].models[j];
        modelList.add(opt);
      }
    }
  }
}



function updateMarkList() {
  removeOptions(markList);
  for(i=0; i<cars.length; i++) {
    let opt = document.createElement("option");
    opt.text = cars[i].mark;
    markList.add(opt);


  }
}

function addNew() {
  let markRadio = document.getElementById("radio-marka").checked;
  let modelRadio = document.getElementById("radio-model").checked;
  let name = document.getElementById("nowa").value;
  let mark = markList.value;
  if(markRadio) {
    let newMark = new Auto(name, []);
    cars.push(newMark);
  }
  else if(modelRadio){
    for(i =0; i<cars.length; i++) {
      if(mark == cars[i].mark) {
        cars[i].addModel(name);
      }
    }
  }
  showModels();
  updateMarkList();
  markList.value = mark;
}


let ford = new Auto("Ford", ["Focus", "Mondeo"]);
let fiat = new Auto("Fiat", ["Punto", "Stilo"]);


let cars = [];
cars.push(ford);
cars.push(fiat);

let modelList = document.getElementById("model");
let markList = document.getElementById("marka");

updateMarkList();
showModels();

markList.addEventListener("change", showModels);
document.getElementById("dodaj").addEventListener("click", addNew);
