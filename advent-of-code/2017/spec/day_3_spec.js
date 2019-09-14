import { expect } from 'chai';

import { part1, part2 } from '../source/day_3';

describe("part1", () => {

  context("when the sample input is provided", () => {

    it("returns the expected result", () => {
      expect(part1("1")).to.eq(0);
      expect(part1("2")).to.eq(1);
      expect(part1("12")).to.eq(3);
      expect(part1("23")).to.eq(2);
      expect(part1("25")).to.eq(4);
      expect(part1("1024")).to.eq(31);
    });
  });
});

describe("part2", () => {

  context("when the sample input is provided", () => {

    it("returns the expected result", () => {
      expect(part2("4")).to.eq(5);
      expect(part2("5")).to.eq(10);
      expect(part2("11")).to.eq(23);
      expect(part2("747")).to.eq(806);
    });
  });
});
