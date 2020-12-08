const input = require("fs").readFileSync("./07/input.txt", "utf8").split("\n");
const colorRegex = /^(\w+ \w+)/g;
const innerBagsRegex = (flags = "") => new RegExp(/(\d) (\w+ \w+)/, flags);

const parseBags = (bags_input) => {
  const bags = {};

  bags_input.forEach((rule) => {
    const color = rule.match(colorRegex)[0];
    const innerBags = rule.match(innerBagsRegex("g"));

    if (innerBags) {
      innerBags.forEach((innerBag) => {
        const [_, amount, name] = innerBag.match(innerBagsRegex());
        const inner = {};
        inner[name] = parseInt(amount, 0);
        bags[color] = {
          ...bags[color],
          ...inner,
        };
      });
    } else {
      bags[color] = {};
    }
  });

  return bags;
};

const bags = parseBags(input);
const bagContainsNBags = (color, bags) => {
  let nBags = 0;
  for (const [bag, n] of Object.entries(bags[color])) {
    nBags += n + n * bagContainsNBags(bag, bags);
  }
  return nBags;
};

console.log(bagContainsNBags("shiny gold", bags)); // 11310
