const input = require("fs").readFileSync("./05/input.txt", "utf8").split("\n");

const findMidpoint = (f) => (a, b) => f((a + b) / 2);
const findLowerMidpoint = findMidpoint(Math.floor);
const findUpperMidpoint = findMidpoint(Math.ceil);

const findSeat = ({ max, ranges }) => {
  let min = 0;
  let result;

  ranges.forEach((range) => {
    if (range === "F" || range === "L") {
      max = findLowerMidpoint(min, max);
      result = max;
    } else {
      min = findUpperMidpoint(min, max);
      result = min;
    }
  });

  return result;
};

const boardingPasses = [];

input.forEach((line, i) => {
  const matches = line.match(/((B|F){7})((L|R){3})/);
  const rows = matches[1].split("");
  const columns = matches[3].split("");

  const row = findSeat({ max: 127, ranges: rows });
  const column = findSeat({ max: 7, ranges: columns });
  const id = row * 8 + column;

  boardingPasses.push({ row, column, id });
});

const highestId = boardingPasses.map((pass) => pass.id).sort((a, b) => a - b)[
  boardingPasses.length - 1
];

console.log(highestId); // 828
