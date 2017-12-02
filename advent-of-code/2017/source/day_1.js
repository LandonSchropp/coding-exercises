import * as R from 'ramda';

// Appends the lookahead digits from the start of the string to the end.
// Number -> String -> String
const extendInput = R.curry((lookahead, input) => {
  return R.concat(input, input.slice(0, lookahead));
});

// Removes all non-repeating characters (using a lookahead) from an extended input.
// Number -> String -> String
const removeNonRepeating = R.curry((lookahead, input) => {
  return R.replace(RegExp(`(.)(?!.{${ lookahead - 1 }}\\1)`, "g"), "", input);
});

// Add all of the digits in the provided string together.
// String -> Number
const addDigits = R.pipe(
  R.split(""),
  R.map(R.curryN(2, parseInt)(R.__, 10)),
  R.reduce(R.add, 0)
);

// Solve the puzzle using the given lookahead number and input.
// Integer -> String -> Integer
const puzzle = R.curry((lookahead, input) => {
  return R.pipe(
    extendInput(lookahead),
    removeNonRepeating(lookahead),
    addDigits
  )(input);
});

// String -> Integer
export const part1 = puzzle(1);

// String -> Integer
export const part2 = input => puzzle(input.length / 2, input);
