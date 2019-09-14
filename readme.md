# Coding Exercises

These are my personal solutions to a variety of coding exercises from various sources. Some of these
sources include:

* [Exercism](https://exercism.io/my/tracks)
* [Advent of Code](https://adventofcode.com/)
* [Structure and Interpretation of Computer Programs](https://amzn.com/0262510871)

Most exercises are written in JavaScript, TypeScript, Ruby and Elixir. To run the code, you'll need to have
those environments set up locally.

## Setting Up Exercism

In order to start using Exercism, first install it with `brew install exercism`. Then, you'll need
to configure the API key using the following command.

``` sh
exercism configure --token=YOUR_API_TOKEN
```

I'm not a fan of Exercism's default directory. To change it to directory in this repo,
make sure you're in the root directory of this project and run the following:

``` sh
exercism configure --workspace "$PWD/exercism"
```
