index_files=$( find -L $1  -maxdepth 2 -name "index.html" )

echo $index_files

for file in $index_files; do
  sub_dir=$( echo $file | sed 's/index.html//' )

  echo $file

  echo "" > "$sub_dir/all.js"

  for js in $( cat $file | grep "script src" | sed 's/.*src="\(.*\)".*/\1/' ); do
    if echo "$js" | grep "all\." > /dev/null; then
      echo "skipping $js"
      continue;
    fi

    cat "$sub_dir$js" >> "$sub_dir/all.js"
  done

  echo "minifying ..."
  node node_modules/.bin/minify --output "$sub_dir/all.min.js" "$sub_dir/all.js"
done
