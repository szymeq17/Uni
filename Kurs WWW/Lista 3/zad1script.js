function checkAccNr() {
  let re = /\b\d{26}\b/;
  let number = document.getElementById("acc-nr").value;
  console.log(number);
  if(re.exec(number) == null) {
    document.getElementById("acc-nr").style.backgroundColor = "#EF8585";
  }
  else {
    document.getElementById("acc-nr").style.backgroundColor = "#95EFC3";
  }
}

function checkPesel() {
  let re = /\b\d{11}\b/;
  let pesel = document.getElementById("pesel").value;
  if(re.exec(pesel) == null) {
    document.getElementById("pesel").style.backgroundColor = "#EF8585";
  }
  else {
    document.getElementById("pesel").style.backgroundColor = "#95EFC3";
  }
}

function checkBirthDate() {
  let re = /\b(0[1-9]|[1-2]\d|31)-(0\d|1[0-2])-(19\d{2}|20[0-1]\d|2020)\b/;
  let date = document.getElementById("birth-date").value;
  if(re.exec(date) == null) {
    document.getElementById("birth-date").style.backgroundColor = "#EF8585";
  }
  else {
    document.getElementById("birth-date").style.backgroundColor = "#95EFC3";
  }

}

function checkEmail() {
  let re = /\b[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\b/;
  let email = document.getElementById("email").value;
  if(re.exec(email) == null) {
    document.getElementById("email").style.backgroundColor = "#EF8585";
    }
  else {
    document.getElementById("email").style.backgroundColor = "#95EFC3";
  }
}

document.getElementById('acc-nr').addEventListener("focusout", checkAccNr);
document.getElementById('pesel').addEventListener("focusout", checkPesel);
document.getElementById('birth-date').addEventListener("focusout", checkBirthDate);
document.getElementById('email').addEventListener("focusout", checkEmail);
