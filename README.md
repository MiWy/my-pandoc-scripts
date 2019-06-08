# my-pandoc-scripts
Self-contained Pandoc setup

Just some scripts for converting papers. **This is not as robust as [pandoc-scholar](https://pandoc-scholar.github.io), [pandocomatic](https://github.com/htdebeer/pandocomatic), or [scrivomatic](https://github.com/iandol/scrivomatic)**.

It is ASAF. Just copy your source .md and .bib files to the _source_ directory and then run 

```bash
sh makefiles.sh
```

A draft and less-of-a-draft PDFs and TeX files will be created in the _output_ directory, along with the .docx

## Dependencies

You need [Pandoc](https://pandoc.org) and a TeX distribution.
