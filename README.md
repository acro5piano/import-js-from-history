# import-js-from-history

easily write import in JavaScript &amp; TypeScript

![](https://github.com/acro5piano/import-js-from-history/blob/master/demo.gif)

# Install

```
Plug 'acro5piano/import-js-from-history'
```

# How it works

`import-js-from-history` make ~/.import-js-list and search it as import candidates.

First, call `:ImportJsMake` to create `~/.import-js-list`. Then run `:ImportJs` where cursor is at imported word.

# Example setting

```
nnoremap <Leader>ij :ImportJs<CR>

```
