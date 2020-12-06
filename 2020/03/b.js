const input = require("fs").readFileSync("./03/input.txt", "utf8").split("\n");
const TREE = "#";

const patterns = [
  { x: 1, y: 1 },
  { x: 3, y: 1 },
  { x: 5, y: 1 },
  { x: 7, y: 1 },
  { x: 1, y: 2 },
];

const trees = [];

patterns.forEach(({ x, y }) => {
  let treeCount = 0;
  let yPos = y;
  let xPos = x;

  input.forEach((row, i) => {
    if (i === yPos) {
      while (row[xPos] === undefined) {
        row += row;
      }

      if (row[xPos] === TREE) {
        treeCount++;
      }

      xPos += x;
      yPos += y;
    }
  });

  trees.push(treeCount);
});

console.log(trees.reduce((a, b) => a * b, 1)); // 3424528800
