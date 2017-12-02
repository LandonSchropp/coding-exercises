import { expect } from 'chai';

import { part1 } from '../source/day_2';

describe.only("part1", () => {

  context("when the sample input is provided", () => {

    it("returns the expected result", () => {
      expect(part1("5 1 9 5\n7 5 3\n2 4 6 8")).to.eq(18);
    });
  });
});
