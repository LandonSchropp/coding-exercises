import * as R from 'ramda';

// Parse the provided days into an array of arrays.
// String -> [ [ Integer ] ]
export const parse = R.pipe(
  R.split("\n"),
  R.map(R.split(/\s+/)),
  R.map(R.map(parseInt))
);

// Returns the max and min values of an array.
// [ Integer ] -> [ Integer ]
const maxAndMin = R.converge(R.unapply(R.identity), [ R.apply(Math.max), R.apply(Math.min) ]);

// Determines if the first number is evenly divisible by the second number.
const isEvenlyDivisible = (first, second) => first !== second && first % second === 0;

// Returns all of the possible pairings of two arrays.
// [ * ] -> [ * ] -> [ [ *, * ] ]
function pairs(numbers) {
  return R.unnest(R.map(x => R.map(y => [ x, y ], numbers), numbers));
}

// Returns the evenly divisible numbers in an array.
// NOTE: This function could easily be made more efficint, but who cares. ¯\_(ツ)_/¯
const evenlyDivisibleNumbers = R.pipe(pairs, R.find(R.apply(isEvenlyDivisible)));

export const part1 = R.pipe(
  parse,
  R.map(R.pipe(maxAndMin, R.apply(R.subtract))),
  R.reduce(R.add, 0)
);

export const part2 = R.pipe(
  parse,
  R.map(R.pipe(evenlyDivisibleNumbers, R.apply(R.divide))),
  R.reduce(R.add, 0)
);
