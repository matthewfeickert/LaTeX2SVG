#!/bin/bash
# Author: Matthew Feickert
# Date: 2015-03-09
# Description: This script takes a LaTeX file and will extract
# the text or image in it, and export it to a SVG.
# NOTE: The LaTeX document MUST use \pagestyle{empty} to avoid
#       a column of whitespace trying to include the page number.

# Check to make sure a file was passed
if [ $# -eq 0 ]
then
  echo "A LaTeX file (.tex) is needed as input."
  exit 1
fi
# Check to make sure a LaTeX file was passed
if [ "${1:(-4)}" != ".tex" ]
then
  echo "A LaTeX file (.tex) is needed as input."
  exit 1
fi
# LaTeX -> SVG Script
if [ "$2" != "verbose" ]        # If verbose option then output to stdout
then
  pdflatex $1 >/dev/null                  # pdflatex the input
  pdfname=${1%.tex}.pdf                   # create variable name ending in .pdf
  pdfcrop --clip $pdfname $pdfname >/dev/null # crop off all whitespace on pdf
  pdf2svg $pdfname ${1%.tex}.svg >/dev/null   # convert to svg
else
  pdflatex $1
  pdfname=${1%.tex}.pdf
  pdfcrop --clip $pdfname $pdfname
  pdf2svg $pdfname ${1%.tex}.svg
fi
# Cleanup
rm -f *.aux *.log *.out
rm -f $pdfname
