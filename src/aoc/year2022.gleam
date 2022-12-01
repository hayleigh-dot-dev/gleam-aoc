import aoc
import aoc/year2022/day1
import node/promise.{Promise}

pub fn solve(day: String) -> Promise(aoc.Solution) {
  case day {
    "1" -> day1.solve()
  }
}
