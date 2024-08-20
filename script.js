let gender = process.argv[2]; // Genero
let height = process.argv[3]; // Altura
let barReps = process.argv[4]; // Repetições com barra
let barSeconds = process.argv[5]; // Tempo das repetições com barra
let abs = process.argv[6]; // Abdominais
let runDistance = process.argv[7]; // Distância da corrida
let runTime = process.argv[8]; // Tempo da corrida
let swimDistance = process.argv[9]; // Distância da natação
let swimTime = process.argv[10]; // Tempo da natação
let diveTime = process.argv[11]; // Tempo de mergulho

passed = false;

if (gender === "male") {
  if (height >= 1.7 && abs >= 41) {
    if (barReps >= 6 || barSeconds >= 15) {
      if (
        (runDistance >= 3000 && runTime <= 720) ||
        (runDistance >= 5000 && runTime <= 1200)
      ) {
        if (
          (swimDistance >= 100 && swimTime <= 60) ||
          (swimDistance >= 100 && diveTime <= 30)
        ) {
          passed = true;
        }
      }
    }
  }
} else if (gender === "female") {
  if (height >= 1.6 && abs >= 41) {
    if (barReps >= 5 || barSeconds >= 12) {
      if (
        (runDistance >= 4000 && runTime <= 900) ||
        (runDistance >= 6000 && runTime <= 1320)
      ) {
        if ((swimDistance >= 100 && swimTime <= 60) || diveTime <= 30) {
          passed = true;
        }
      }
    }
  }
} else {
  passed = false;
}

console.log(passed);
