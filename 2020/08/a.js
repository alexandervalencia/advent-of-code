const input = require("fs").readFileSync("./08/input.txt", "utf8").split("\n");

const runProgram = (instructions) => {
  const seenIndexes = [];
  let index = 0;
  let accumulator = 0;
  let newInstruction = true;

  while (newInstruction) {
    if (seenIndexes.indexOf(index) === -1) {
      seenIndexes.push(index);
      let [cmd, amt] = instructions[index].split(" ");

      switch (cmd) {
        case "acc":
          accumulator += parseInt(amt, 0);
          index++;
          break;
        case "jmp":
          index += parseInt(amt, 0);
          break;
        case "nop":
        default:
          index++;
      }
    } else {
      newInstruction = false;
    }
  }

  return accumulator;
};

console.log(runProgram(input)); // 1337
