import { isValid, part1 } from '../source/day_4';
import { expect } from 'chai';

describe("isValid", () => {

  context("when the phrase contains no duplicate words", () => {

    it("returns true", () => {
      expect(isValid([ "aa", "bb", "cc", "dd", "ee" ])).to.eq(true);
    });
  });

  context("when the phrase contains a duplicate word", () => {

    it("returns false", () => {
      expect(isValid([ "aa", "bb", "cc", "dd", "aa" ])).to.eq(false);
    });
  });

  context("when the phrase contains a word contained in another word", () => {

    it("returns true", () => {
      expect(isValid([ "aa", "bb", "cc", "dd", "aaa" ])).to.eq(true);
    });
  });
});

describe("part1", () => {

  context("when the example is provided", () => {

    it("returns the expected value", () => {
      expect(part1("aa bb cc dd ee\naa bb cc dd aa\naa bb cc dd aaa")).to.eq(2);
    });
  });
});
