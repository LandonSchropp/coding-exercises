import _ from 'lodash';

export const compute = (left, right) => {
  if (left.length === 0 && right.length > 0) { throw "left strand must not be empty"; }
  if (right.length === 0 && left.length > 0) { throw "right strand must not be empty"; }
  if (right.length !== left.length) { throw "left and right strands must be of equal length"; }

  return _.sum(_.zipWith(_.split(left, ''), _.split(right, ''), (a, b) => a === b ? 0 : 1));
};
