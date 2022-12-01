#!/usr/bin/env node

import * as Dotenv from "dotenv";
import * as Fs from "node:fs";
import * as Path from "node:path";
import * as Process from "node:process";
import * as Url from "node:url";

// You don't get the handy __dirname and __filename variables using esm modules.
// This little trick gets them back!
const here = Url.fileURLToPath(new URL(".", import.meta.url));
const build_dir = Path.join(here, "../build/dev/javascript/aoc");
const src_dir = Path.join(here, "../src");

copy_ffi_files();

const entry = Path.join(build_dir, "main.mjs");
const gleam = Path.join(build_dir, "gleam.mjs");

// We want to import the Gleam prelude so we can convert the arguments list from
// a js array to a Gleam list.
const Gleam = await import(gleam);
const App = await import(entry);

Dotenv.config();
App.main(Gleam.List.fromArray(Process.argv.slice(2))).then(console.log);

//

function copy_ffi_files(relative_path = ".") {
  const from = Path.join(src_dir, relative_path);
  const to = Path.join(build_dir, relative_path);

  for (const file of Fs.readdirSync(from)) {
    const stat = Fs.lstatSync(`${from}/${file}`);

    switch (true) {
      case stat.isDirectory(): {
        Fs.mkdirSync(`${to}/${file}`, { recursive: true });
        copy_ffi_files(`${relative_path}/${file}`);
        break;
      }

      case stat.isFile() && Path.extname(file) === ".mjs": {
        Fs.copyFileSync(`${from}/${file}`, `${to}/${file}`);
        break;
      }
    }
  }
}
