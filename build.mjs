import { build } from 'esbuild'
import { cp, mkdir } from 'node:fs/promises'
import { join } from 'node:path'

const ROOT = process.cwd()
const SRC = join(ROOT, 'src')
const OUT = join(ROOT, 'dist')

// Ensure dist directory exists
await mkdir(OUT, { recursive: true })

const base = {
  sourcemap: true,
  bundle: true,
  external: ['jquery'],
}

// ESM build (vanilla JS only)
await build({
  ...base,
  entryPoints: [join(SRC, 'LicenseSelector.ts')],
  outfile: join(OUT, 'license-selector.esm.js'),
  format: 'esm',
  target: 'es2020',
})

// UMD build (vanilla JS + optional jQuery, IIFE with global name)
await build({
  ...base,
  entryPoints: [join(SRC, 'LicenseSelector.ts')],
  outfile: join(OUT, 'license-selector.umd.js'),
  format: 'iife',
  globalName: 'LicenseSelector',
})

// jQuery integration build (separate file for optional use)
await build({
  ...base,
  entryPoints: [join(SRC, 'jquery-integration.ts')],
  outfile: join(OUT, 'license-selector.jquery.js'),
  format: 'iife',
  globalName: 'LicenseSelectorJQuery',
})

// Copy CSS
await cp(join(SRC, 'styles.css'), join(OUT, 'license-selector.css'))

// Copy image assets (no font files needed — replaced icon font with text arrows)
const imgDirs = ['img/licenses']
for (const dir of imgDirs) {
  const srcDir = join(SRC, dir)
  const dstDir = join(OUT, dir)
  await mkdir(dstDir, { recursive: true })
  const fs = await import('node:fs/promises')
  for (const file of await fs.readdir(srcDir)) {
    await fs.cp(join(srcDir, file), join(dstDir, file))
  }
}

console.log('Build complete: dist/license-selector.{esm,umd,jquery}.js + license-selector.css')
