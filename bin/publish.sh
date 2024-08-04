#!/bin/bash


source_base_dir="docsrc"
target_base_dir="docs"

rm -rf "$target_base_dir" 
mkdir -p "$target_base_dir"

mkdir -p "$target_base_dir/assets/fonts"
cp -r "$source_base_dir/assets/fonts" "$target_base_dir/assets/"

mkdir -p "$target_base_dir/assets/img"
cp -r "$source_base_dir/assets/img" "$target_base_dir/assets/"

mkdir -p "$target_base_dir/assets/js"
mkdir -p "$target_base_dir/assets/css"

npm run minify-js 
npm run minify-cssmain
npm run minify-cssprint
npm run minify-html

if [ -n "$1" ]; then
    git add -A .
    git commit -m "${1}"
    git push origin main 
fi

