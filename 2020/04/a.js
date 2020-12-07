const input = require("fs")
  .readFileSync("./04/input.txt", "utf8")
  .split("\n\n");
input.forEach((line, i) => (input[i] = line.replace(/\n/g, " ")));

const serializePassports = (passports) => {
  return passports.map((passport) => {
    const fieldsArray = passport.split(" ");
    const serializedPassport = {};

    fieldsArray.forEach((fieldLine) => {
      const fieldMatches = fieldLine.match(/(^\w{3}):(.*)/);
      serializedPassport[fieldMatches[1]] = fieldMatches[2];
    });

    return serializedPassport;
  });
};

const countValidPassports = (passports) => {
  const filteredPassports = passports.map((passport) => {
    delete passport.cid;
    return passport;
  });
  return filteredPassports.reduce((count, passport) => {
    if (Object.keys(passport).length == 7) count++;
    return count;
  }, 0);
};

const serializedPassports = serializePassports(input);
const validPassportCount = countValidPassports(serializedPassports);

console.log(validPassportCount);
