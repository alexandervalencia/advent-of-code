const input = require("fs")
  .readFileSync("./input.txt", "utf8")
  .split("\n")
  .map((s) => Number(s));

const sumToTwentyTwenty = (a, b) => a + b === 2020;

for (let i = 0; i < input.length; i++) {
  for (let j = 0; j < input.length; j++) {
    if (sumToTwentyTwenty(input[i], input[j])) {
      console.log(input[i] * input[j]); // 1020084
    }
  }
}
