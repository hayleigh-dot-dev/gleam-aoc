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
  // I know that some people might be reading Gleam for the first time looking at
  // this, so what's this `use` thing all about? First thing you should know is
  // at time of writing this is still shiny and new, so I am probably going to
  // overuse the heck out of it.
  //
  // `use` is actually just some simple syntax sugar for callback functions. Instead
  // of opening a lambda and nesting our code, we can keep things nice and flat.
  // 
  // ```gleam
  // use n <- list.map([1, 2, 3])
  // n + 1
  // ```
  //
  // is the same as
  //
  // ```gleam
  // list.map([1, 2, 3], fn (n) {
  //   n + 1
  // })
  // ```
  //
  // Everything after the `use` binding happens the callback function, so you can
  // think of it like every `use` secretly indents your code 2 spaces.
  //
  use inventory <- list.map(elves)
  let items = string.split(inventory, "\n")
  use total, item <- list.fold(items, 0)
  let kcal = int.parse(item) |> result.unwrap(0)

  total + kcal
}