// IMPORTS ---------------------------------------------------------------------

import aoc
import gleam/list
import gleam/set
import gleam/string
import gleam/option.{Option, Some}
import node/promise.{Promise}

// SOLUTION --------------------------------------------------------------------

pub fn solve(part: Option(String)) -> Promise(aoc.Challenge) {
  use input <- aoc.puzzle("2022", "3")
  let input = string.split(input, "\n")

  aoc.Challenge(
    title: "Rucksack Reorganization",
    year: 2022,
    day: 3,
    solution: case part {
      Some("1") -> aoc.Partial(1, solve_part_one(input))
      Some("2") -> aoc.Partial(2, solve_part_two(input))
      _ -> aoc.Complete(solve_part_one(input), solve_part_two(input))
    },
  )
}

fn solve_part_one(input: List(String)) -> Int {
  use total, rucksack <- list.fold(input, 0)
  let items = string.to_graphemes(rucksack)
  let #(first, second) = list.split(items, list.length(items) / 2)

  assert [shared] =
    first
    |> set.from_list
    |> set.filter(list.contains(second, _))
    |> set.to_list

  total + priority(shared)
}

fn solve_part_two(input: List(String)) -> Int {
  let groups = list.sized_chunk(input, 3)
  use total, group <- list.fold(groups, 0)

  assert [a, b, c] = group
  assert [shared] =
    string.to_graphemes(a)
    |> set.from_list
    |> set.filter(fn(s) { string.contains(b, s) && string.contains(c, s) })
    |> set.to_list

  total + priority(shared)
}

// UTILS -----------------------------------------------------------------------

fn priority(item: String) -> Int {
  case <<item:utf8>> {
    <<prio:int>> if prio > 97 -> prio - 96
    <<prio:int>> -> prio - 38
  }
}
