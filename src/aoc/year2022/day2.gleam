// IMPORTS ---------------------------------------------------------------------

import aoc
import gleam/function
import gleam/int
import gleam/option.{Option, Some}
import nibble.{Break, Continue}
import node/promise.{Promise}

// TYPES -----------------------------------------------------------------------

type Move {
  Rock
  Paper
  Scissors
}

type Outcome {
  Lose
  Draw
  Win
}

// SOLUTION --------------------------------------------------------------------

pub fn solve(part: Option(String)) -> Promise(aoc.Challenge) {
  use input <- aoc.puzzle("2022", "2")

  aoc.Challenge(
    title: "Rock Paper Scissors",
    year: 2022,
    day: 2,
    solution: case part {
      Some("1") -> aoc.Partial(1, solve_part_one(input))
      Some("2") -> aoc.Partial(2, solve_part_two(input))
      _ -> aoc.Complete(solve_part_one(input), solve_part_two(input))
    },
  )
}

fn solve_part_one(input: String) -> Int {
  let op_move =
    nibble.one_of([
      nibble.map(nibble.grapheme("A"), fn(_) { Rock }),
      nibble.map(nibble.grapheme("B"), fn(_) { Paper }),
      nibble.map(nibble.grapheme("C"), fn(_) { Scissors }),
    ])

  let my_move =
    nibble.one_of([
      nibble.map(nibble.grapheme("X"), fn(_) { Rock }),
      nibble.map(nibble.grapheme("Y"), fn(_) { Paper }),
      nibble.map(nibble.grapheme("Z"), fn(_) { Scissors }),
    ])

  let step = function.curry2(fn(op, me) { round_to_score(op, me) })

  assert Ok(score) =
    nibble.run(
      input,
      nibble.loop(
        0,
        fn(total) {
          nibble.one_of([
            nibble.succeed(step)
            |> nibble.keep(op_move)
            |> nibble.drop(nibble.spaces())
            |> nibble.keep(my_move)
            |> nibble.drop(nibble.whitespace())
            |> nibble.map(int.add(_, total))
            |> nibble.map(Continue),
            nibble.succeed(total)
            |> nibble.drop(nibble.eof())
            |> nibble.map(Break),
          ])
        },
      ),
    )

  score
}

fn solve_part_two(input: String) -> Int {
  let op_move =
    nibble.one_of([
      nibble.map(nibble.grapheme("A"), fn(_) { Rock }),
      nibble.map(nibble.grapheme("B"), fn(_) { Paper }),
      nibble.map(nibble.grapheme("C"), fn(_) { Scissors }),
    ])

  let outcome =
    nibble.one_of([
      nibble.map(nibble.grapheme("X"), fn(_) { Lose }),
      nibble.map(nibble.grapheme("Y"), fn(_) { Draw }),
      nibble.map(nibble.grapheme("Z"), fn(_) { Win }),
    ])

  let step =
    function.curry2(fn(op, outcome) {
      let me = outcome_to_move(op, outcome)
      round_to_score(op, me)
    })

  assert Ok(score) =
    nibble.run(
      input,
      nibble.loop(
        0,
        fn(total) {
          nibble.one_of([
            nibble.succeed(step)
            |> nibble.keep(op_move)
            |> nibble.drop(nibble.spaces())
            |> nibble.keep(outcome)
            |> nibble.drop(nibble.whitespace())
            |> nibble.map(int.add(_, total))
            |> nibble.map(Continue),
            nibble.succeed(total)
            |> nibble.drop(nibble.eof())
            |> nibble.map(Break),
          ])
        },
      ),
    )

  score
}

// UTILS -----------------------------------------------------------------------

fn outcome_to_move(op: Move, outcome: Outcome) -> Move {
  case op, outcome {
    Rock, Lose -> Scissors
    Rock, Draw -> Rock
    Rock, Win -> Paper
    Paper, Lose -> Rock
    Paper, Draw -> Paper
    Paper, Win -> Scissors
    Scissors, Lose -> Paper
    Scissors, Draw -> Scissors
    Scissors, Win -> Rock
  }
}

fn move_to_score(move: Move) -> Int {
  case move {
    Rock -> 1
    Paper -> 2
    Scissors -> 3
  }
}

fn round_to_score(op: Move, me: Move) -> Int {
  case op, me {
    Rock, Rock -> 3 + move_to_score(Rock)
    Rock, Paper -> 6 + move_to_score(Paper)
    Rock, Scissors -> 0 + move_to_score(Scissors)
    Paper, Rock -> 0 + move_to_score(Rock)
    Paper, Paper -> 3 + move_to_score(Paper)
    Paper, Scissors -> 6 + move_to_score(Scissors)
    Scissors, Rock -> 6 + move_to_score(Rock)
    Scissors, Paper -> 0 + move_to_score(Paper)
    Scissors, Scissors -> 3 + move_to_score(Scissors)
  }
}
