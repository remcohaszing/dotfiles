const repository = `remcohaszing/${basename}`
const github = 'https://github.com'
const url = `${github}/${repository}`

module.exports = {
  name: basename,
  version: '0.0.0',
  description: prompt('description', ''),
  keywords: [],
  homepage: `${url}#readme`,
  bugs: `${url}/issues`,
  repository,
  funding: `${github}/sponsors/remcohaszing`,
  license: 'MIT',
  author: 'Remco Haszing <remcohaszing@gmail.com>',
  sideEffects: false,
  type: 'module',
  exports: './index.js',
  files: [],
  scripts: {
    prepack: 'tsc --noEmit false',
    test: 'node --test'
  },
  devDependencies: {
    eslint: '^8.0.0',
    'eslint-config-remcohaszing': '^8.0.0',
    prettier: '^8.0.0',
    typescript: '^4.0.0',
  },
  engines: {
    node: '>=14.0.0'
  }
}
