// This implementation of reduce was part of the reduceIt exercise from
// https://github.com/jorge0136/reduce-javascript-practice.
const reduce = (collection, iteratee, accumulator) => {

  for (let key in collection) {
    accumulator = iteratee(accumulator, collection[key], key)
  }

  return accumulator;
}

export const keep = () => {
  throw new Error("Remove this statement and implement this function");
};

export const discard = () => {
  throw new Error("Remove this statement and implement this function");
};
