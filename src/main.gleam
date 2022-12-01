import aoc
import gleam/io

pub fn main(argv: List(String)) {
  assert [year, day, _, ..] = argv

  use input <- aoc.puzzle(year, day)
  io.debug(input)
}
