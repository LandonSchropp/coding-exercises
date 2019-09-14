// This implementation of reduce was part of the reduceIt exercise from
// https://github.com/jorge0136/reduce-javascript-practice.
const reduce = (collection, iteratee, accumulator) => {

  for (let key in collection) {
    accumulator = iteratee(accumulator, collection[key], key)
  }

  return accumulator;
}

export const keep = (collection, predicate) => {
  return reduce(collection, (accumulator, element) => {
    return predicate(element) ? [ ...accumulator, element ] : accumulator;
  }, []);
};

export const discard = (collection, predicate) => {
  return keep(collection, element => !predicate(element));
};
