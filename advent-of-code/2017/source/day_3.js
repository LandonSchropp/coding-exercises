import * as R from 'ramda';

const STEPS = [
  [ 1, 0 ],
  [ 0, 1 ],
  [ -1, 0 ],
  [ 0, -1 ]
];

function shouldChangeDirection([ x, y ]) {
  let isBottomRight = x > 0 && y <= 0;
  return isBottomRight && x === -y + 1 || !isBottomRight && Math.abs(x) === Math.abs(y);
}

// Adds two coordinates together, returning a new coordinates array.
function addCoordinates([ x1, y1 ], [ x2, y2 ]) {
  return [ x1 + x2, y1 + y2 ];
}

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

// Returns the taxi cab distance for the given coordinates.
// [ Integer ] -> Integer
const taxiCabDistance = R.pipe(R.map(Math.abs), R.apply(R.add));

export const part1 = R.pipe(
  parseInt,
  R.add(-1),
  toCoordinates,
  taxiCabDistance
);
