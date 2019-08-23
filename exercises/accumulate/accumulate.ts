// I'm cheating the problem description here a bit to show how all of the Lodash array
// transformation functions can be rewritten using reduce.
export default <E>(array: E[], iteratee: (element: E) => any) => {
  return array.reduce(
    (result, element) => {
      result.push(iteratee(element))
      return result
    },
    [] as E[]
  )
}
