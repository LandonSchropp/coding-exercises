import { isValid, part1, isValidWithAnagram } from '../source/day_4';
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

describe("isvalidWithAnagram", () => {

  context("when the words contain no duplicates with anagrams", () => {

    it("returns true", () => {
      expect(isValidWithAnagram([ 'abcde', 'fghij' ])).to.eq(true);
    });
  });

  context("when the words contain a duplicate as an anagram", () => {

    it("returns false", () => {
      expect(isValidWithAnagram([ 'abcde', 'xyz', 'ecdab' ])).to.eq(false);
    });
  });

  context("when the words contain duplicate letters, but not as anagrams", () => {

    it("returns true", () => {
      expect(isValidWithAnagram([ 'a', 'ab', 'abc', 'abd', 'abf', 'abj' ])).to.eq(true);
    });
  });
});
