import _ from "lodash";

export class NucleotideCounts {

  static parse(dna) {
    if (!/^[ACGT]*$/.test(dna)) {
      throw new Error("Invalid nucleotide in strand");
    }

    return _.values({ A: 0, C: 0, G: 0, T: 0, ..._.countBy(dna.split('')) }).join(" ");
  }
}
