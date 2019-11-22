#!/usr/bin/env bash

del_these=(".DS_Store" ".pek")
dry_run=0

find "$1" -depth -print0 | while IFS= read -r -d '' file; do
  d="$( dirname "$file" )"
  f="$( basename "$file" )"
  #new="${f//[^a-zA-Z0-9\/\._\-]/_}"
  new=`echo ${f} | sed 's/[^a-zA-Z0-9\/\._\-]/_/g' | sed -E 's/(_){2,}/_/g' |sed 's/^[^a-zA-Z0-9]*//g' | sed 's/[^a-zA-Z0-9]*$//g' | sed 's/COM\([0-9]\)/COM_\1/g'`
  #echo ${new} | grep .txt
  # if the file has an extension that matches one listed in del_these array, then delete it.
  if  [[ " ${del_these[@]} " =~ ${f/#*./.} ]]
  then
    if [ "$dry_run" eq 1 ];
    then
        echo deleteing "${d}/${f}"
        rm -rf "${d}/${f}"
        continue
    else
        echo will delete "${d}/${f}"
        continue
    fi
  fi

  if [ "$f" != "$new" ]   # if equal, name is already clean, so leave alone
  then
    if [ -e "$d/$new" ]
    then
      echo "Notice: \"$new\" and \"$f\" both exist in "$d":"
      ls -ld "$d/$new" "$d/$f"
    else
      if [ "$dry_run" eq 1 ];
      then
        echo rename "$file" to "$d/$new"
        mv "$file" "$d/$new"
      else
        echo will rename "$file" to "$d/$new"
        echo mv "$file" "$d/$new"
      fi
    fi
  fi
done
