#!/usr/bin/env node
async function main() {

}

if (module === require.main) {
  main().catch(err => {
    console.error(err);
    process.exit(1);
  });
}
