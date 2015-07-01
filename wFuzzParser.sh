#!/bin/sh
#TODO: Extract URL from wfuzz result

echo "Welcome to wFuzz results parser"

#Extract URL
target=$(cat $1 | grep Target | awk '{print $2}' | grep -o "http\(s\)\{0,1\}://.*\.[a-z]\{1,3\}")
echo "We're gonna work with "$target

#Process results and extract URL Lists
cat $1 | while read line;
do
 httpCode=$(echo $line | awk '{print $2}' | grep -o '[0-9]\{3\}')
 if [ -n "$httpCode" ];
 then
  #HTTP Codes where URLLists will be created
  if [ "$httpCode" -eq 200 ] || [ "$httpCode" -eq 403 ] || [ "$httpCode" -eq 405 ] ;
  then
   #Redirect = Absolute URL No-Redirect = Must be built
   redirectIndicator=$(echo $line | awk '{print $10}' | grep -o "\(\*\)")
   if [ -n "$redirectIndicator" ];
   then
    url=$(echo $line | awk '{print $11}')
   else
    url=$target"/"$(echo $line | awk '{print $12}' | sed 's/"$//g;s/^\///g')
   fi
   echo $url >> TEMP$httpCode"UrlList.txt"
   #echo "$( echo $line | awk '{print $10 " @ "$11 " @ "  $12 }')"
  fi
  echo "$line" >> "processed_"$httpCode"Codes.txt"
 fi
done

#Sort URL Lists
ls TEMP* | while read line;
do
 newname=$(echo $line | sed 's/TEMP//g')
 cat $line | sort -u >> $newname
 rm $line
done

echo "K, done :)"
