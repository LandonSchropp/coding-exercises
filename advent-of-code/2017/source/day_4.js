import * as R from 'ramda';

export function isValid(words) {
  return words.length === R.uniq(words).length;
}

export const part1 = R.pipe(
  R.split("\n"),
  R.map(R.split(" ")),
  R.map(isValid),
  R.map(value => +value),
  R.reduce(R.add, 0)
);
