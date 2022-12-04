import aoc/year2022
import gleam/dynamic.{Dynamic}
import gleam/string
import gleam/option
import gleam/list
import node/fs
import node/path
import node/promise.{Promise, do, throw}

pub fn main(argv: List(String)) -> Promise(Dynamic) {
  case argv {
    ["setup", year, day, ..] -> {
      let aoc_path = path.join([path.src(), "aoc"])
      let out_dir = path.join([aoc_path, "year" <> year])
      let out_path = path.join([out_dir, "day" <> day <> ".gleam"])
      let template_path = path.join([aoc_path, "_template.gleam"])
      use template <- do(fs.read(template_path))
      use _ <- do(fs.mkdir(out_dir))
      let solution =
        template
        |> string.replace("{{year}}", year)
        |> string.replace("{{day}}", day)
      use _ <- do(fs.write(out_path, solution))
      return("Setup complete")
    }

    ["run", "2022", day, ..part] -> {
      let part = option.from_result(list.first(part))
      use solution <- do(year2022.solve(day, part))
      return(solution)
    }

    _ -> throw("Invalid arguments")
  }
}

fn return(val: a) -> Promise(Dynamic) {
  promise.return(dynamic.from(val))
}
