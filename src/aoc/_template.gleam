// IMPORTS ---------------------------------------------------------------------

import aoc
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import node/promise.{Promise}


// SOLUTION --------------------------------------------------------------------

pub fn solve() -> Promise(aoc.Solution) {
  use input <- aoc.puzzle("{{year}}", "{{day}}")
  let input = parse_input(input)

  aoc.Solution(
    year: {{year}},
    day: {{day}},
    title: "",
    solution: #(solve_part_one(input), solve_part_two(input))
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