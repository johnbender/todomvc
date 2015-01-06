#! /bin/bash
if [ -z "$1" ]; then
  echo "Usage concat-min.sh <public folder>"
  echo "e.g."
  echo "bash bin/concat-min.sh public/"
  exit 1
fi

index_files=$( find -L $1  -maxdepth 2 -name "index.html" )

echo "Project index files to get js from: "
echo $index_files
echo

for file in $index_files; do
  sub_dir=$( echo $file | sed 's/\/index.html//' )
  project=$( echo $file | sed 's/.*\/\([a-z_]*\)\/index.html/\1/' )

  echo "Working on:  $file"
  echo "Project:     $project"

  all_file="$sub_dir/$project.all.js"
  min_file="$sub_dir/$project.all.min.js"

  echo "" > "$sub_dir/$project.all.js"

  echo "Including: "
  for js in $( cat $file | grep "script" | grep "src" | sed 's/.*src="\(.*\)".*/\1/' ); do
    if echo "$js" | grep "all\." > /dev/null; then
      echo "Skipping:    *.all.*"
      continue;
    fi

    echo "$js"

    cat "$sub_dir/$js" >> "$all_file"
  done

  echo "Minifying:   $all_file ..."
  node node_modules/.bin/minify --output $min_file $all_file
  echo
done
