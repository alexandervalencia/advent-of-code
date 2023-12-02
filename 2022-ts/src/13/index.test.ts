import { assertEquals } from "https://deno.land/std@0.167.0/testing/asserts.ts";
import Today from "./index.ts";

const filepath = [
  ...new URL(import.meta.url).pathname.split("/").slice(0, -1),
].join("/");

const input = await Deno.readTextFile(`${filepath}/input.txt`);

Deno.test("Example - Part A", () => {
  const example = `[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]`;
  const simpleExample = `[1,1,3,1,1]
[1,1,5,1,1]

[7,7,7,7]
[7,7,7,5]`;
  const describedClass = new Today(simpleExample);
  // assertEquals(3, describedClass);
});

// Deno.test("Part A", () => {
//   const describedClass = new Today(input);
//   assertEquals(599, describedClass);
// });
