import * as Path from "node:path";

export const join = (segments) => Path.join(...segments.toArray());
export const src = () => global.src_dir;
