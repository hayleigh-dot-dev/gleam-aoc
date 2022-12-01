// TYPES -----------------------------------------------------------------------

pub external type Promise(a, e)

// CONSTRUCTORS ----------------------------------------------------------------

/// Create a Promise that always resolves with the given value.
///
pub external fn return(val: a) -> Promise(a, e) =
  "./promise.ffi.mjs" "resolve"

/// Create a Promise that always rejects with the given error.
///
pub external fn throw(err: e) -> Promise(a, e) =
  "./promise.ffi.mjs" "reject"

// MANIPULATIONS ---------------------------------------------------------------

/// Attempt a Promise that might fail. In case of a rejection, you're given the
/// error as an opportunity to recover.
///
pub external fn attempt(promise: Promise(a, e), f: fn(Result(a, e)) -> Promise(b, e)) -> Promise(b, e) =
  "./promise.ffi.mjs" "attempt"

/// Perform a Promise and do something with the result.
///
pub fn do(promise: Promise(a, e), f: fn(a) -> Promise(b, e)) -> Promise(b, e) {
  use result <- attempt(promise)

  case result {
    Ok(a) -> f(a)
    Error(e) -> throw(e)
  }
}

/// Perform a Promise and transform its result.
///
pub fn map(promise: Promise(a, e), f: fn(a) -> b) -> Promise(b, e) {
  use a <- do(promise)

  return(f(a))
}
