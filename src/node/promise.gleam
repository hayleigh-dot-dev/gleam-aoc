// IMPORTS ---------------------------------------------------------------------

import gleam/dynamic.{Dynamic}

// TYPES -----------------------------------------------------------------------

pub external type Promise(a)

// CONSTRUCTORS ----------------------------------------------------------------

/// Create a Promise that always resolves with the given value.
///
pub external fn return(val: a) -> Promise(a) =
  "./promise.ffi.mjs" "resolve"

/// Create a Promise that always rejects with the given error.
///
pub external fn throw(err: e) -> Promise(a) =
  "./promise.ffi.mjs" "reject"

// MANIPULATIONS ---------------------------------------------------------------

/// Attempt a Promise that might fail. In case of a rejection, you're given the
/// error as an opportunity to recover.
///
pub external fn attempt(promise: Promise(a), k: fn(Result(a, Dynamic)) -> Promise(b)) -> Promise(b) =
  "./promise.ffi.mjs" "attempt"

/// Perform a Promise and do something with the result.
///
pub fn do(promise: Promise(a), k: fn(a) -> Promise(b)) -> Promise(b) {
  use result <- attempt(promise)

  case result {
    Ok(a) -> k(a)
    Error(e) -> throw(e)
  }
}

/// Perform a Promise and transform its result.
///
pub fn map(promise: Promise(a), f: fn(a) -> b) -> Promise(b) {
  use a <- do(promise)

  return(f(a))
}
