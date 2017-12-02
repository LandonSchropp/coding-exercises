import { expect } from 'chai';

import { part1 } from '../source/day_1';

describe("part1", () => {

  context("when the sample inputs are provided", () => {

    it("returns the provided solutions", () => {
      expect(part1("1122")).to.equal(3);
      expect(part1("1111")).to.equal(4);
      expect(part1("1234")).to.equal(0);
      expect(part1("91212129")).to.equal(9);
    });
  });
});
