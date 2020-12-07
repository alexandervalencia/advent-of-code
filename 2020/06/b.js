const input = require("fs").readFileSync("./06/input.txt", "utf8");
const groups = input.split("\n\n").map((group) => group.split("\n"));

let unanimousAnswers = groups.reduce((count, group) => {
  const groupAnswers = {};
  group.forEach((answers) =>
    answers.split("").forEach((answer) => {
      if (!groupAnswers[answer]) groupAnswers[answer] = 0;
      groupAnswers[answer]++;
    })
  );

  for (const [_, v] of Object.entries(groupAnswers)) {
    if (v === group.length) {
      count++;
    }
  }

  return count;
}, 0);

console.log(unanimousAnswers); // 3125
