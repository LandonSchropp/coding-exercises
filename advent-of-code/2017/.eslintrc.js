module.exports = {
  extends: "optimum-energy",
  env: {
    mocha: true
  },
  parserOptions: {
    ecmaVersion: 7,
    sourceType: "module",
    ecmaFeatures: {
      impliedStrict: true,
      experimentalObjectRestSpread: true
    }
  }
}
