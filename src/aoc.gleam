import node/fs
import node/promise.{Promise, attempt, do, return}

// TYPES -----------------------------------------------------------------------

///
///
pub type Solution {
  Solution(
    year: Int,
    day: Int,
    title: String,
    solution: #(Int, Int)
  )
}

// 

external fn download(year: String, day: String) -> Promise(String) =
  "./aoc.ffi.mjs" "download"

external fn dat() -> String =
  "./aoc.ffi.mjs" "dat_dir"

/// Get the puzzle input for a given year and day. This will first check the local
/// cache, and if it is missing it will download it from the Advent of Code website.
///
/// ❓ Why is the last argument called `k`? It's an old convention from Scheme
/// and other languages to call a continuation `k`. It's a function that takes
/// the result of some computation and continues the computation.
///
pub fn puzzle(year: String, day: String, k: fn(String) -> a) -> Promise(a) {
  let path = dat() <> "/" <> year <> "_" <> day <> ".txt"

  // Attempt to read the puzzle input from our local cache first. This might fail
  // and we want to recover from that, so we use `attempt` rather than `do` to
  // catch the error and put it into a `Result` for us.
  use file <- attempt(fs.read(path))

  case file {
    Ok(input) -> return(k(input))

    // If we don't have this input cached yet, we'll try and download it from the
    // aoc website directly. It's important we remember to write the input to our
    // cache so we don't have to make this request more than once!
    Error(_) -> {
      use input <- do(download(year, day))
      use _ <- do(fs.write(path, input))
      return(k(input))
    }
  }
}
