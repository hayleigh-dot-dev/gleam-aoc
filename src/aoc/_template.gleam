// IMPORTS ---------------------------------------------------------------------

import aoc
import gleam/int
import gleam/list
import gleam/option.{Option, Some}
import gleam/result
import gleam/string
import node/promise.{Promise}


// SOLUTION --------------------------------------------------------------------

pub fn solve() -> Promise(aoc.Challenge) {
  use input <- aoc.puzzle("{{year}}", "{{day}")
  let input = parse_input(input)

  aoc.Challenge(
    title: "",
    year: {{year}},
    day: {{day}},
    solution: case part {
      Some("1") -> aoc.Partial(1, solve_part_one(input))
      Some("2") -> aoc.Partial(2, solve_part_two(input))
      _ -> aoc.Complete(solve_part_one(input), solve_part_two(input))
    },
  )
}

fn solve_part_one(input: ?) -> Int {
  todo
}

fn solve_part_two(input: ?) -> Int {
  todo
}

// UTILS -----------------------------------------------------------------------

fn parse_input(input: String) -> ? {
  todo
}