#!/bin/bash
HTML_DIR="./build/html"
HAXFU="haxfu"
CS6795="cs6795"

cd $HTML_DIR
mv _sources source
mv _static static
mv _images images
sed -i 's/_images/images/g' *.html 
sed -i 's/_static/static/g' *.html 
sed -i 's/_sources/sources/g' *.html

cd $HAXFU
sed -i 's/_images/images/g' *.html 
sed -i 's/_static/static/g' *.html 
sed -i 's/_sources/sources/g' *.html

cd ../$CS6795
sed -i 's/_images/images/g' *.html 
sed -i 's/_static/static/g' *.html 
sed -i 's/_sources/sources/g' *.html
