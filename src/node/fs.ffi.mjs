import * as Fs from "node:fs/promises";

export const read = (path) => Fs.readFile(path, { encoding: "utf8" });
export const write = (path, content) => Fs.writeFile(path, content);
