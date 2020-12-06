const input = require("fs").readFileSync("./03/input.txt", "utf8").split("\n");
const TREE = "#";
let x = 3;
let treeCount = 0;

input.forEach((row, i) => {
  if (i !== 0) {
    while (row[x] === undefined) {
      row += row;
    }

    if (row[x] === TREE) {
      treeCount++;
    }
    x += 3;
  }
});

console.log(treeCount); // 145
