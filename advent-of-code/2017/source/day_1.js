import * as R from 'ramda';

// String -> Integer
export default R.pipe(

  // Instead of mucking around with complicated regular expressions, simply duplicate the last
  // character.
  R.converge(R.concat, [ R.identity, R.head ]),

  // Remove all non-repeating characters
  R.replace(/(.)(?!\1)/g, ""),

  // Parse the remaining digits and add them together
  R.split(""),
  R.map(R.curryN(2, parseInt)(R.__, 10)),
  R.reduce(R.add, 0)
);
