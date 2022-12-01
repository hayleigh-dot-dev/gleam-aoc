# Gleam + JavaScript + AOC = 🎅💕

## Quickstart

<img src="https://cdn.mckayla.cloud/-/6289d0b8271940b1ae61bd93c1374c97/Lucy-Advent.svg" width="200" height="200" align="right"/>

- Make sure you have Gleam installed and working.

- Create an empty `dat` directory. This is where your puzzle inputs will be stored.
  If you want to hardcode some inputs or you don't want to bother fetching them
  automatically, you can put them here.

  Inputs should be named `{year}_{day}` (e.g. `2022_1` for the first day of 2022).

- Create a `.env` file with your session cookie from the aoc website. It should
  look something like:

```
AOC_COOKIE=3408242...
```

- Run `npm install` to install any JavaScript dependencies we need. I've tried to
  keep the project light on dependencies, at the time of writing we only have
  one: `dotenv`.

- Run `npm start -- {year} {day} {part}` to run the solution for a given day and
  part. If the puzzle input cannot be found in the `dat` directory, it will be
  fetched automatically.

## Included Gleam packages

- `nibble` is a parser combinator library capable of parsing small to medium-sized
  inputs. It's a bit like `nom` in Rust or `parsec` in Haskell, and is particularly
  useful for puzzles with structured input like instructions.

## Extra info

- `aoc` directories are hidden by `.gitignore`. You may want to undo that if you
  want to commit your solutions.
