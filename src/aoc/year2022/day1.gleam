// IMPORTS ---------------------------------------------------------------------

import aoc
import gleam/int
import gleam/list
import gleam/option.{Option, Some}
import gleam/result
import gleam/string
import node/promise.{Promise}

// SOLUTION --------------------------------------------------------------------

pub fn solve(part: Option(String)) -> Promise(aoc.Challenge) {
  use input <- aoc.puzzle("2022", "1")
  let kcals = parse_input(input)

  aoc.Challenge(
    title: "Calorie Counting",
    year: 2022,
    day: 1,
    solution: case part {
      Some("1") -> aoc.Partial(1, solve_part_one(kcals))
      Some("2") -> aoc.Partial(2, solve_part_two(kcals))
      _ -> aoc.Complete(solve_part_one(kcals), solve_part_two(kcals))
    },
  )
}

fn solve_part_one(kcals: List(Int)) -> Int {
  list.fold(kcals, 0, int.max)
}

fn solve_part_two(kcals: List(Int)) -> Int {
  list.sort(kcals, fn(x, y) { int.compare(y, x) })
  |> list.take(3)
  |> int.sum()
}

// UTILS -----------------------------------------------------------------------

fn parse_input(input: String) -> List(Int) {
  let elves = string.split(input, "\n\n")
  use inventory <- list.map(elves)
  let items = string.split(inventory, "\n")
  use total, item <- list.fold(items, 0)
  let kcal =
    int.parse(item)
    |> result.unwrap(0)

  total + kcal
}
