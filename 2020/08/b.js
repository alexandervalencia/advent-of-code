const input = require("fs").readFileSync("./08/input.txt", "utf8").split("\n");

const swapInstruction = (instruction) => {
  let [cmd, amt] = instruction.split(" ");

  return cmd === "nop"
    ? `jmp ${amt}`
    : cmd === "jmp"
    ? `nop ${amt}`
    : instruction;
};

const runProgram = (instructions) => {
  let accumulator = 0;
  let instructionIndex = 0;

  while (accumulator === 0) {
    let updatedInstructions = [...instructions];
    updatedInstructions[instructionIndex] = swapInstruction(
      updatedInstructions[instructionIndex]
    );

    let index = 0;
    let seenIndexes = [];
    let newInstruction = true;

    while (newInstruction) {
      if (seenIndexes.indexOf(index) === -1) {
        seenIndexes.push(index);
        let [cmd, amt] = updatedInstructions[index].split(" ");

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

        if (index >= updatedInstructions.length) {
          newInstruction = false;
        }
      } else {
        accumulator = 0;
        newInstruction = false;
      }
    }

    instructionIndex++;
  }

  return accumulator;
};

console.log(runProgram(input)); // 1358
