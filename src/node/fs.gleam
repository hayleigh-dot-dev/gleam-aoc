// IMPORTS ---------------------------------------------------------------------

import node/promise.{Promise}

//

pub external fn read(path: String) -> Promise(String) =
  "./fs.ffi.mjs" "read"

pub external fn write(path: String, data: String) -> Promise(Nil) =
  "./fs.ffi.mjs" "write"

pub external fn mkdir(path: String) -> Promise(Nil) =
  "./fs.ffi.mjs" "mkdir"