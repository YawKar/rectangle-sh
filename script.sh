#!/bin/bash

print_help() {
  echo "Usage example:"
  echo "  ./script.sh -l <length> -w <width>"
  echo ""
  echo "Args:"
  echo "  -l <length>   length of the rectangle"
  echo "  -w <width>    width of the rectangle"
  echo ""
}

is_positive() {
  local number=$1
  if [ $number -gt 0 ]; then
    return 0
  else
    return 1
  fi
}

while getopts 'l:w:h' opt; do
  case "$opt" in
    l)
      length=$OPTARG
      # echo "Processing option 'l' with '${OPTARG}' argument"
      ;;
    w)
      width=$OPTARG
      # echo "Processing option 'w' with '${OPTARG}' argument"
      ;;
    *)
      print_help
      exit 1
      ;;
  esac
done

if [ -z "$length" ]; then
  length=$LENGTH_ENV
fi

if [ -z "$width" ]; then
  width=$WIDTH_ENV
fi

if [ -z "$length" ]; then
  echo -e "error: length was not specified"
  print_help
  exit 1
fi

if [ -z "$width" ]; then
  echo -e "error: width was not specified"
  print_help
  exit 1
fi

number_regexp='^[+-]?[0-9]+$'
if ! [[ $length =~ $number_regexp ]]; then
   echo -e "error: specified length is not a number"
   exit 1
fi
if ! [[ $width =~ $number_regexp ]]; then
   echo -e "error: specified width is not a number"
   exit 1
fi

if ! is_positive $length; then
  echo -e "error: specified length isn't a positive number"
  exit 1
fi
if ! is_positive $width; then
  echo -e "error: specified width isn't a positive number"
  exit 1
fi

perimeter=$((2 * ($length + $width)))

echo "$perimeter" > out.txt

exit 0
