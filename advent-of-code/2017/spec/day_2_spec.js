import { expect } from 'chai';

import { part1, part2 } from '../source/day_2';

describe("part1", () => {

  context("when the sample input is provided", () => {

    it("returns the expected result", () => {
      expect(part1("5 1 9 5\n7 5 3\n2 4 6 8")).to.eq(18);
    });
  });
});

describe("part2", () => {

  context("when the sample input is provided", () => {

    it("returns the expected result", () => {
      expect(part2("5 9 2 8\n9 4 7 3\n3 8 6 5")).to.eq(9);
    });
  });
});
