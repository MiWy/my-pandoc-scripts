#  Script converts multimarkdown file to latex, pdf, doc and others
# Assumptions: source bibliography.bib and manuscript.md in /source, and spbasic.bst in styles
# Directory structure:
# - /styles 
# - /output
# - /source
# You need to change author name in these preamble templates: 
# - tex_preamble.tex
# - drafttex_preamble.tex 

PAPER="manuscript.md"
BIBLIOGRAPHY="bibliography.bib"

# Copy source files
cp source/$PAPER output/$PAPER
cp source/$BIBLIOGRAPHY output/$BIBLIOGRAPHY
cp styles/spbasic.bst output/spbasic.bst
cp styles/apa.csl output/apa.csl
cp -r fonts/ output
cp tex_preamble.tex output/tex_preamble.tex
cp drafttex_preamble.tex output/drafttex_preamble.tex

# CONVERT DOCUMENTS
cd output

# # TeX
pandoc $PAPER -t latex --pdf-engine=xelatex \
-s --natbib --bibliography=$BIBLIOGRAPHY -V natbiboptions:"round" -V biblio-style:"spbasic" \
--number-sections -V indent:true -V papersize:a4 -V fontsize:10pt \
--include-in-header=tex_preamble.tex \
 -o manuscript_main.tex

# # Draft TeX
pandoc $PAPER -t latex --pdf-engine=xelatex \
-s --natbib --bibliography=$BIBLIOGRAPHY -V natbiboptions:"round" -V biblio-style:"spbasic" \
--number-sections -V indent:true -V papersize:a4 -V fontsize:10pt \
--include-in-header=drafttex_preamble.tex \
-o manuscript_draft.tex

# # TeX PDF
xelatex manuscript_main
bibtex manuscript_main
xelatex manuscript_main
xelatex manuscript_main

# # Draft PDF
xelatex manuscript_draft
bibtex manuscript_draft
xelatex manuscript_draft
xelatex manuscript_draft

# Docx
pandoc -s -o manuscript.docx $PAPER --filter=pandoc-citeproc --bibliography=$BIBLIOGRAPHY --csl="apa.csl" 

# STOP CONVERTING
cd ..

# CLEANUP
cd output
find . -name "*.otf" -type f -delete
find . -name "*.ttf" -type f -delete
find . -name "*.bib" -type f -delete
find . -name "*.log" -type f -delete
find . -name "*.blg" -type f -delete
find . -name "*.aux" -type f -delete
find . -name "*.bst" -type f -delete
find . -name "*.cls" -type f -delete
find . -name "tex_preamble.tex" -type f -delete
find . -name "drafttex_preamble.tex" -type f -delete
cd ..

