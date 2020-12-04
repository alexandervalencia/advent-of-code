const input = require("fs")
  .readFileSync("./input.txt", "utf8")
  .split("\n")
  .map((s) => Number(s));

const sumToTwentyTwenty = (a, b, c) => a + b + c === 2020;

for (let i = 0; i < input.length; i++) {
  for (let j = 0; j < input.length; j++) {
    for (let k = 0; k < input.length; k++) {
      if (sumToTwentyTwenty(input[i], input[j], input[k])) {
        console.log(input[i] * input[j] * input[k]);
      }
    }
  }
}
