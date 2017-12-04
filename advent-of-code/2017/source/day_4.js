import * as R from 'ramda';

export function isValid(words) {
  return words.length === R.uniq(words).length;
}

export const isValidWithAnagram = R.pipe(
  R.map(R.split("")),
  R.map(R.sortBy(R.identity)),
  R.map(R.join("")),
  isValid
);

const validCount = R.curry((validation, input) => {
  return R.pipe(
    R.split("\n"),
    R.map(R.split(" ")),
    R.map(validation),
    R.map(value => +value),
    R.reduce(R.add, 0)
  )(input);
});

export const part1 = validCount(isValid);
export const part2 = validCount(isValidWithAnagram);
