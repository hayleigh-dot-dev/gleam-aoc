// IMPORTS ---------------------------------------------------------------------

import aoc
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import node/promise.{Promise}


// SOLUTION --------------------------------------------------------------------

pub fn solve() -> Promise(aoc.Solution) {
  use input <- aoc.puzzle("2022", "1")
  let kcals = parse_input(input)

  aoc.Solution(
    year: 2022,
    day: 1,
    title: "Calorie Counting",
    solution: #(solve_part_one(kcals), solve_part_two(kcals))
  )
}

fn solve_part_one(kcals: List(Int)) -> Int {
  list.fold(kcals, 0, int.max) 
}

fn solve_part_two(kcals: List(Int)) -> Int {
  list.sort(kcals, fn (x, y) { int.compare(y, x)})
  |> list.take(3)
  |> int.sum()
}

// UTILS -----------------------------------------------------------------------

fn parse_input(input: String) -> List(Int) {
  let elves = string.split(input, "\n\n")
  use inventory <- list.map(elves)
  let items = string.split(inventory, "\n")
  use total, item <- list.fold(items, 0)
  let kcal = int.parse(item) |> result.unwrap(0)

  total + kcal
}