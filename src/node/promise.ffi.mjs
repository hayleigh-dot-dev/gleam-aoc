import * as Gleam from "../gleam.mjs";

export const resolve = (a) => Promise.resolve(a);
export const reject = (e) => Promise.reject(e);
export const attempt = (promise, f) =>
  promise
    .then((a) => new Gleam.Ok(a))
    .catch((e) => new Gleam.Error(e))
    .then(f);
