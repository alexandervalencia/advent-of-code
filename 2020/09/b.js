const { answer } = require("./a");
const input = require("fs")
  .readFileSync("./09/input.txt", "utf8")
  .split("\n")
  .map((n) => parseInt(n, 10));

const target = answer;

const numbersUpToTarget = input.slice(0, input.indexOf(target));

const findContiguousNumbers = (numbers) => {
  let contiguousNumbers = [];

  for (let i = 0; i < numbers.length; i++) {
    let sum = numbers[i];
    let nextNumber = i + 1;

    contiguousNumbers.push(numbers[i]);

    for (let j = nextNumber; j < numbers.length; j++) {
      sum += numbers[j];
      contiguousNumbers.push(numbers[j]);

      if (sum > target) {
        contiguousNumbers = [];
        break;
      } else if (sum === target) {
        break;
      }
    }

    if (sum === target) break;
  }

  return contiguousNumbers;
};

const contiguousNumbers = findContiguousNumbers(numbersUpToTarget);

const sortedNumbers = [...contiguousNumbers].sort((a, b) => a - b);

const answer = sortedNumbers[0] + sortedNumbers[sortedNumbers.length - 1];

console.log(answer); // 238243506
