import * as R from 'ramda';

const parse = R.pipe(
  R.split('\n'),
  R.map(parseInt)
);

const performSteps = (jumps) => {
  jumps = R.clone(jumps);

  let step = 0;
  let index = 0;

  while (index >= 0 && index < jumps.length) {
    let jump = jumps[index];
    jumps[index] = jumps[index] + 1;
    index = index + jump;
    step++;
  }

  return step;
};

export const part1 = R.pipe(
  parse,
  performSteps
);
