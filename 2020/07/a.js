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

const canContain = (color, bags) => {
  const results = [];

  for (const c in bags) {
    if (color in bags[c]) {
      results.push(c);
    }
  }

  return results;
};

const canContainRecursive = (color, bags) => {
  const validBags = new Set();
  validBags.add(color);

  let gotNewBag = true;

  while (gotNewBag) {
    gotNewBag = false;

    for (const bag of validBags) {
      for (const c of canContain(bag, bags)) {
        if (!validBags.has(c)) {
          validBags.add(c);
          gotNewBag = true;
        }
      }
    }
  }

  validBags.delete(color);

  return validBags.size;
};

console.log(canContainRecursive("shiny gold", bags));
