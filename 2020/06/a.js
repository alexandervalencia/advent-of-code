const input = require("fs").readFileSync("./06/input.txt", "utf8");
const groups = input.split("\n\n").map((group) => group.replace(/\n/g, ""));

const totalAnswers = groups.reduce((count, group) => {
  const answers = new Set();

  group.split("").forEach((answer) => {
    answers.add(answer);
  });

  return (count += answers.size);
}, 0);

console.log(totalAnswers); // 6430
