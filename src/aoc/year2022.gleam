import aoc
import aoc/year2022/day1
import aoc/year2022/day2
import aoc/year2022/day3
import aoc/year2022/day4
import gleam/option.{Option}
import node/promise.{Promise}

pub fn solve(day: String, part: Option(String)) -> Promise(aoc.Challenge) {
  case day {
    "1" -> day1.solve(part)
    "2" -> day2.solve(part)
    "3" -> day3.solve(part)
    "4" -> day4.solve(part)
  }
}
