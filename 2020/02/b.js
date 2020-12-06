const input = require("fs").readFileSync("./02/input.txt", "utf8").split("\n");
let passwordCount = 0;

input.forEach((line) => {
  const matches = line.match(/(\d{1,2})-(\d{1,2}) (\w): (\w*)/);
  const pos1 = matches[1] - 1;
  const pos2 = matches[2] - 1;
  const ltr = matches[3];
  const pwd = matches[4];

  if (
    (pwd.charAt(pos1) === ltr && pwd.charAt(pos2) !== ltr) ||
    (pwd.charAt(pos1) !== ltr && pwd.charAt(pos2) === ltr)
  ) {
    passwordCount++;
  }
});

console.log(passwordCount); // 482
