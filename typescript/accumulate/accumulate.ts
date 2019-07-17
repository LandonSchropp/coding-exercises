// I'm cheating the problem description here a bit to show how all of the Lodash array
// transformation functions can be rewritten using reduce.
export default (array: any[], iteratee: (element: any) => any) => {
  return array.reduce(
    (result, element) => {
      result.push(iteratee(element))
      return result
    },
    []
  )
}
