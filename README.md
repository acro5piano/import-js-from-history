# import-js-from-history

Make it easy to write `import` statement in JavaScript & TypeScript.

![](https://github.com/acro5piano/import-js-from-history/blob/master/demo-2.gif)

# Install

```
Plug 'acro5piano/import-js-from-history'
```

# How it works

- First of all, call `:ImportJsMake` to create `~/.import-js-list`, which is search candidates.
- And call `:ImportJs` (or `:ImportJsFZF`) when the cursor is on the word to import.

# Example setting

```
nnoremap <Leader>ij :ImportJsFZF<CR>

```
