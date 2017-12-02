import * as R from 'ramda';

// Parse the provided days into an array of arrays.
// String -> [ [ Integer ] ]
export const parse = R.pipe(
  R.split("\n"),
  R.map(R.split(/\s+/)),
  R.map(R.map(parseInt))
);

// Determine the row's checksum (min + max)
// [ Integer ] -> Integer
const rowChecksum = R.converge(R.subtract, [ R.apply(Math.max), R.apply(Math.min) ]);

export const part1 = R.pipe(
  parse,
  R.map(rowChecksum),
  R.reduce(R.add, 0)
);
