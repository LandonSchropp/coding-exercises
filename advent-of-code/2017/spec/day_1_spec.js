import { expect } from 'chai';

import day1 from '../source/day_1';

describe("day1", () => {

  context("when the sample inputs are provided", () => {

    it("returns the provided solutions", () => {
      expect(day1("1122")).to.equal(3);
      expect(day1("1111")).to.equal(4);
      expect(day1("1234")).to.equal(0);
      expect(day1("91212129")).to.equal(9);
    });
  });
});
