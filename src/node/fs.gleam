// IMPORTS ---------------------------------------------------------------------

import gleam/dynamic.{Dynamic}
import node/promise.{Promise}

//

pub external fn read(path: String) -> Promise(String, Dynamic) =
  "./fs.ffi.mjs" "read"

pub external fn write(path: String, data: String) -> Promise(Nil, Dynamic) =
  "./fs.ffi.mjs" "write"
