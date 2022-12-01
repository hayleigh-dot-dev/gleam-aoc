import * as Path from "node:path";
import * as Process from "node:process";
import * as Url from "node:url";

export const download = (year, day) => {
  const url = `https://adventofcode.com/${year}/day/${day}/input`;
  const cookie = Process.env.AOC_COOKIE;
  return fetch(url, { headers: { Cookie: `session=${cookie}` } }).then(
    (response) => response.text()
  );
};

// Remember this FFI file will be copied over to Gleam's build directory, so the
// `here` variable is relative to *that* and *not* where you are probably editing
// this file.
export const dat_dir = () => {
  const here = Url.fileURLToPath(new URL(".", import.meta.url));
  return Path.join(here, "../../../../dat");
};
