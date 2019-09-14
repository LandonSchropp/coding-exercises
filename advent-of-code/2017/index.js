import fs from 'fs';
import path from 'path';

if (process.argv.length !== 4) {
  process.stderr.write("Usage: yarn run -- <DAY> <PART>");
  process.exit(1);
}

let [ day, part ] = process.argv.slice(2);
let input = fs.readFileSync(path.join(__dirname, `inputs/day_${ day }.txt`), 'utf-8').trim();
let func = require(`./source/day_${ day }`)[`part${ part }`];

process.stdout.write(func(input).toString());
