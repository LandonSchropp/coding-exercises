import * as R from 'ramda';

const parse = R.pipe(
  R.split('\n'),
  R.map(parseInt)
);

const performSteps = R.curry((incrementFunction, jumps) => {
  jumps = R.clone(jumps);

  let step = 0;
  let index = 0;

  while (index >= 0 && index < jumps.length) {
    let jump = jumps[index];
    jumps[index] = jump + incrementFunction(jump);
    index = index + jump;
    step++;
  }

  return step;
});

export const part1 = R.pipe(
  parse,
  performSteps(R.always(1))
);

export const part2 = R.pipe(
  parse,
  performSteps(jump => jump >= 3 ? -1 : 1)
);
