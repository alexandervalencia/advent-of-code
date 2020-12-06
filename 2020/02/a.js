const input = require("fs").readFileSync("./02/input.txt", "utf8").split("\n");
let passwordCount = 0;

input.forEach((line) => {
  const matches = line.match(/(\d{1,2})-(\d{1,2}) (\w): (\w*)/);
  const min = matches[1];
  const max = matches[2];
  const ltr = matches[3];
  const pwd = matches[4];
  const ltrRegex = new RegExp(ltr, "g");
  const ltrCount = pwd.replace(ltrRegex, "0").replace(/[^0]/g, "").length;

  if (ltrCount >= min && ltrCount <= max) {
    passwordCount++;
  }
});

console.log(passwordCount); // 483
