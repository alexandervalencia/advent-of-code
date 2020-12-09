const input = require("fs")
  .readFileSync("./09/input.txt", "utf8")
  .split("\n")
  .map((n) => parseInt(n, 10));

const preambleSize = 25;

const validateNumber = (number, group) => {
  let valid = false;
  for (let i = 0; i < group.length; i++) {
    let indexToCheck = i + 1;
    for (let j = indexToCheck; j < group.length; j++) {
      if (group[i] + group[j] === number) valid = true;
    }
  }

  return valid;
};

const findFirstInvalidNumber = (numbers) => {
  let invalidNumber;
  let preambleStart = 0;

  while (!invalidNumber) {
    for (let i = preambleSize; i < numbers.length; i++) {
      let previousGroup = numbers.slice(
        preambleStart,
        preambleStart + preambleSize
      );

      if (validateNumber(numbers[i], previousGroup)) {
        preambleStart++;
        continue;
      } else {
        invalidNumber = numbers[i];
        break;
      }
    }
  }

  return invalidNumber;
};

const answer = findFirstInvalidNumber(input);

console.log(answer); // 1492208709

module.exports = { answer };
