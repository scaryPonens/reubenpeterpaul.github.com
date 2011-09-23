#!/bin/bash
BASE_DIR=$(pwd)
HTML_DIR="$BASE_DIR/build/html"
HAXFU="$HTML_DIR/haxfu"
CS6795="$HTML_DIR/cs6795"

cd $HTML_DIR
mv _sources source
mv _static static
mv _images images
sed -i 's/_images/images/g' *.html  #TODO: make procedure for these sed commands
sed -i 's/_static/static/g' *.html 
sed -i 's/_sources/sources/g' *.html
mv main.html index.html

cd $HAXFU
sed -i 's/_images/images/g' *.html 
sed -i 's/_static/static/g' *.html 
sed -i 's/_sources/sources/g' *.html

cd $CS6795
sed -i 's/_images/images/g' *.html 
sed -i 's/_static/static/g' *.html 
sed -i 's/_sources/sources/g' *.html
