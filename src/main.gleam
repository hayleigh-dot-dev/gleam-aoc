import aoc
import aoc/year2022
import node/promise.{Promise}

pub fn main(argv: List(String)) -> Promise(aoc.Solution) {
  assert [year, day, ..] = argv

  case year {
    "2022" -> year2022.solve(day)
  }
}
