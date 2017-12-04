import * as R from 'ramda';

const STEPS = [
  [ 1, 0 ],
  [ 0, 1 ],
  [ -1, 0 ],
  [ 0, -1 ]
];

const SURROUNDING = [
  [ -1, -1 ],
  [ -1, 0 ],
  [ -1, 1 ],
  [ 0, -1 ],
  [ 0, 1 ],
  [ 1, -1 ],
  [ 1, 0 ],
  [ 1, 1 ]
];

function shouldChangeDirection([ x, y ]) {
  let isBottomRight = x > 0 && y <= 0;
  return isBottomRight && x === -y + 1 || !isBottomRight && Math.abs(x) === Math.abs(y);
}

// Adds two coordinates together, returning a new coordinates array.
const addCoordinates = R.curry(([ x1, y1 ], [ x2, y2 ]) => {
  return [ x1 + x2, y1 + y2 ];
});

// Given a number, this function returns the coordinates of the number. It assumes the center
// coordinate is 0.
function toCoordinates(n) {

  // The coordinates start in the center
  let step = STEPS.length - 1;
  let coordinates = [ 0, 0 ];

  // Do this for each value on the board.
  R.times(() => {

    // Change direction if we've hit a corner
    if (shouldChangeDirection(coordinates)) {
      step = (step + 1) % STEPS.length;
    }

    // Determine the next set of coordinates
    coordinates = addCoordinates(coordinates, STEPS[step]);
  }, n);

  return coordinates;
}

function toGridKey([ x, y ]) {
  return `${ x } ${ y }`;
}

// This is my dirty solution to part 2. This could be rewritten to be much cleaner, but it's not
// worth the effort.
function valueBiggerThan(maxValue) {
  let grid = {};

  for (let i = 0; i < Infinity; i++) {
    let coordinates = toCoordinates(i);

    let value = R.pipe(
      R.map(addCoordinates(coordinates)),
      R.map(toGridKey),
      R.map(R.propOr(0, R.__, grid)),
      R.reduce(R.add, 0)
    )(SURROUNDING) || 1;

    grid[toGridKey(coordinates)] = value;

    if (value > maxValue) {
      return value;
    }
  }
}

// Returns the taxi cab distance for the given coordinates.
// [ Integer ] -> Integer
const taxiCabDistance = R.pipe(R.map(Math.abs), R.apply(R.add));

export const part1 = R.pipe(
  parseInt,
  R.add(-1),
  toCoordinates,
  taxiCabDistance
);

export const part2 = R.pipe(
  parseInt,
  valueBiggerThan
);
