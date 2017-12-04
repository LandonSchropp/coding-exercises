import * as R from 'ramda';

// This problem can be solved with math. The number pattern looks like this:
//
// 17 16 15 14 13
// 18  5  4  3 12
// 19  6  1  2 11
// 20  7  8  9 10
// 21 22 23 24 25
//
// And the distance pattern looks like this:
//
// 6 5 4 3 4 5 6
// 5 4 3 2 3 4 5
// 4 3 2 1 2 3 4
// 3 2 1 0 1 2 3
// 4 3 2 1 2 3 4
// 5 4 3 2 3 4 5
// 6 5 4 3 4 5 6

// Converts a number to its corresponding distance from the center. This assumes n is zero-based.
// Integer -> Integer
function distance(n) {

  // The math doesn't work when n is 0
  if (n === 0) { return 0; }

  // First,  determine which ring a number is in (with the first being ring 0).
  let ringNumber = Math.floor((Math.sqrt(n) + 1) / 2);

  // Determine the minimum and maximum distances for a given ring.
  let minimumRingDistance = ringNumber;
  let maximumRingDistance = ringNumber * 2;

  // Determine the value for the ring, ignoring the inner rings and starting at 0.
  const ringN = n - (ringNumber * 2 - 1) ** 2;

  // Determine how far away a number is from the center of its ring.
  let ringSideDistance = Math.abs(ringN % maximumRingDistance - (minimumRingDistance - 1));

  // The ring number is the horizontal distance. The side distance is the vertical distance. Add
  // them to get the result.
  return ringNumber + ringSideDistance;
}

export const part1 = R.pipe(
  parseInt,
  R.add(-1),
  distance
);
