// IMPORTS ---------------------------------------------------------------------

import aoc
import gleam/list
import gleam/option.{Option, Some}
import gleam/function
import gleam/result
import nibble.{Break, Continue, Parser}
import node/promise.{Promise}

// TYPES -----------------------------------------------------------------------

type Assignment =
  #(Int, Int)

type Pair =
  #(Assignment, Assignment)

// SOLUTION --------------------------------------------------------------------

pub fn solve(part: Option(String)) -> Promise(aoc.Challenge) {
  use input <- aoc.puzzle("2022", "4")
  let input = parse_input(input)

  aoc.Challenge(
    title: "Camp Cleanup",
    year: 2022,
    day: 4,
    solution: case part {
      Some("1") -> aoc.Partial(1, solve_part_one(input))
      Some("2") -> aoc.Partial(2, solve_part_two(input))
      _ -> aoc.Complete(solve_part_one(input), solve_part_two(input))
    },
  )
}

fn solve_part_one(input: List(Pair)) -> Int {
  use total, pair <- list.fold(input, 0)
  let #(a, b) = pair

  case subsumes(a, b) || subsumes(b, a) {
    True -> total + 1
    False -> total
  }
}

fn solve_part_two(input: List(Pair)) -> Int {
  use total, pair <- list.fold(input, 0)
  let #(a, b) = pair

  case intersects(a, b) || intersects(b, a) {
    True -> total + 1
    False -> total
  }
}

// UTILS -----------------------------------------------------------------------

fn subsumes(a: Assignment, b: Assignment) -> Bool {
  a.0 >= b.0 && a.1 <= b.1
}

fn intersects(a: Assignment, b: Assignment) -> Bool {
  a.0 <= b.1 && a.1 >= b.0
}

fn parse_input(input: String) -> List(Pair) {
  nibble.run(input, assignment_pairs())
  |> result.unwrap([])
}

fn assignment() -> Parser(Assignment, ctx) {
  let pair = function.curry2(fn(x, y) { #(x, y) })
  let int = nibble.int()

  nibble.succeed(pair)
  |> nibble.keep(int)
  |> nibble.drop(nibble.grapheme("-"))
  |> nibble.keep(int)
}

fn assignment_pair() -> Parser(Pair, ctx) {
  let pair = function.curry2(fn(x, y) { #(x, y) })
  let assignment = assignment()

  nibble.succeed(pair)
  |> nibble.keep(assignment)
  |> nibble.drop(nibble.grapheme(","))
  |> nibble.keep(assignment)
}

fn assignment_pairs() -> Parser(List(Pair), ctx) {
  nibble.loop(
    [],
    fn(pairs) {
      nibble.one_of([
        nibble.succeed(list.prepend(pairs, _))
        |> nibble.keep(assignment_pair())
        |> nibble.drop(nibble.whitespace())
        |> nibble.map(Continue),
        nibble.succeed(pairs)
        |> nibble.drop(nibble.eof())
        |> nibble.map(list.reverse)
        |> nibble.map(Break),
      ])
    },
  )
}
