import _ from "lodash";

function encodeWord(word) {
  return `${ word.length > 1 ? word.length : "" }${ word[0] }`;
}

function decodeWord(word) {
  let [ , count, character ] = word.match(/(\d*)([^\d])/);
  return _.repeat(character, count || 1);
}

export const encode = (string) => {
  return _.words(string, /(.)\1*/g)
    .map(encodeWord)
    .join("");
};

export const decode = (string) => {
  return _.words(string, /(\d*)([^\d])/g)
    .map(decodeWord)
    .join("");
};
