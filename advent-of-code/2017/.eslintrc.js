module.exports = {
  extends: "optimum-energy",
  env: {
    mocha: true
  },
  parserOptions: {
    ecmaVersion: 6,
    sourceType: "module",
    ecmaFeatures: {
      impliedStrict: true,
      experimentalObjectRestSpread: true
    }
  }
}
