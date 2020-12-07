const input = require("fs")
  .readFileSync("./04/input.txt", "utf8")
  .split("\n\n");
input.forEach((line, i) => (input[i] = line.replace(/\n/g, " ")));

const heightRule = (height) => {
  const type = height.match(/cm|in/)[0];
  const value = height.match(/\d{2,3}/)[0];

  return type === "cm"
    ? value >= 150 && value <= 193
    : value >= 59 && value <= 76;
};

const fields = {
  byr: {
    regex: /\d{4}/,
    rule: (n) => n >= 1920 && n <= 2002,
  },
  iyr: {
    regex: /\d{4}/,
    rule: (n) => n >= 2010 && n <= 2020,
  },
  eyr: {
    regex: /\d{4}/,
    rule: (n) => n >= 2020 && n <= 2030,
  },
  hgt: {
    regex: /\d{2,3}(cm|in)/,
    rule: heightRule,
  },
  hcl: {
    regex: /^#[0-9a-f]{6}/,
    rule: () => true,
  },
  ecl: {
    regex: /amb|blu|brn|gry|grn|hzl|oth/,
    rule: () => true,
  },
  pid: {
    regex: /\d{9}/,
    rule: (n) => n.length === 9,
  },
};

const serializePassports = (passports) => {
  return passports.map((passport) => {
    const fieldsArray = passport.split(" ");
    const serializedPassport = {};

    fieldsArray.forEach((fieldLine) => {
      const fieldMatches = fieldLine.match(/(^\w{3}):(.*)/);
      serializedPassport[fieldMatches[1]] = fieldMatches[2];
    });

    delete serializedPassport.cid;

    return serializedPassport;
  });
};

const validatePassport = (passport) => {
  let valid = true;

  const keys = Object.keys(passport);

  keys.forEach((k) => {
    if (!fields[k].regex.test(passport[k])) {
      valid = false;
    } else if (!fields[k].rule(passport[k])) {
      valid = false;
    }
  });

  return valid;
};

const countValidPassports = (passports) => {
  return passports.reduce((count, passport, i) => {
    if (Object.keys(passport).length !== 7) {
      return count;
    } else if (validatePassport(passport)) {
      count++;
    }

    return count;
  }, 0);
};

const serializedPassports = serializePassports(input);
const validPassportCount = countValidPassports(serializedPassports);

console.log(validPassportCount); // 140
