#!/usr/bin/env bash

tests_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo Creating "platformspace" test folder
if [ -e "${tests_dir}/platformspace" ]
then
    rm -rf ${tests_dir}/platformspace
fi
mkdir -p ${tests_dir}/platformspace/\&\$\#kladfs\@\:89\:687
mkdir -p ${tests_dir}/platformspace/perfectlyfine_dir
# echo expected renamed path into files to check against each of the files renamed by renamer.sh
touch "${tests_dir}/platformspace/.DS_Store"
touch "${tests_dir}/platformspace/test.pek"

echo "${tests_dir}/platformspace/kladfs_89_687/H3_enBerg-1_20_2008_start.txt" >  ${tests_dir}/platformspace/\&\$\#kladfs\@\:89\:687/H3\!\$enBerg-1\:20\:2008_start.txt
echo "${tests_dir}/platformspace/kladfs_89_687/Hector_SalamanCOM_0.txt" >  ${tests_dir}/platformspace/\&\$\#kladfs\@\:89\:687/Hector_SalamanCOM0.txt
echo "${tests_dir}/platformspace/kladfs_89_687/skyler_goodie_two_shoes.txt" > ${tests_dir}/platformspace/\&\$\#kladfs\@\:89\:687/skyler_goodie_two_shoes.txt
echo "${tests_dir}/platformspace/kladfs_89_687/TuCOM_097_Salamanca.txt" >  ${tests_dir}/platformspace/\&\$\#kladfs\@\:89\:687/TuCOM097\ Salamanca.txt
echo "${tests_dir}/platformspace/perfectlyfine_dir/Gu_Fr_ng_yo.txt" >  ${tests_dir}/platformspace/perfectlyfine_dir/Gu\$Fr\!ng_yo.txt
echo "${tests_dir}/platformspace/perfectlyfine_dir/Jesse_Pinkman.txt" >  ${tests_dir}/platformspace/perfectlyfine_dir/___Jesse_Pinkman.txt___
echo "${tests_dir}/platformspace/perfectlyfine_dir/Skinny_Pete_Rocks_.txt" >  ${tests_dir}/platformspace/perfectlyfine_dir/\ \ \ Skinny\ Pete\!\!\ Rocks\!.txt\ \ 
echo "${tests_dir}/platformspace/perfectlyfine_dir/Hank-Schrader.txt" > ${tests_dir}/platformspace/perfectlyfine_dir/Hank-Schrader.txt

find ${tests_dir}/platformspace -depth -print0 | while IFS= read -r -d '' file; do
    echo "created: ${file}"
done
echo "running renamer.sh:"

/bin/bash ${tests_dir/%tests/}renamer.sh ${tests_dir}/platformspace

echo "Testing results:"

find ${tests_dir}/platformspace -depth -print0 | while IFS= read -r -d '' file; do
  d="$( dirname "$file" )"
  f="$( basename "$file" )"
  if [[ $f == *.txt* ]]
  then
    if [[ "${d}/${f}" == `cat "${d}/${f}"` ]]
    then
      echo "Test Passed! renamed as expected: ${d}/${f}"
    else
      echo "FAIL!!!! ${d}/${f} should be renamed `cat "${d}/${f}"`"
    fi
  fi
done