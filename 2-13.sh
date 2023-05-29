#!/bin/bash

# Helper-function. Used for printing the 'help' message.
print_help() {
  echo "Usage example:"
  echo "  ./script.sh -l <length> -w <width>"
  echo ""
  echo "Args:"
  echo "  -l <length>   length of the rectangle"
  echo "  -w <width>    width of the rectangle"
  echo ""
}

# Util-function. Used as a predicate.
is_positive() {
  local number=$1
  if [ $number -gt 0 ]; then
    return 0
  else
    return 1
  fi
}

# Common way to parse arguments using getopts built-in command
# l: and w: mean that these arguments have values like '-l 12' or '-w -w' (value will be '-w')
while getopts 'l:w:' opt; do
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

# If length wasn't specified as a command line argument (therefore wasn't defined)
if [ -z "$length" ]; then
  # Try to take its value from LENGTH_ENV environment variable
  length=$LENGTH_ENV
fi

# If width wasn't specified as a command line argument (therefore wasn't defined)
if [ -z "$width" ]; then
  # Try to take its value from WIDTH_ENV environment variable
  width=$WIDTH_ENV
fi

# If it was specified neither as argument, nor as an environment variable
if [ -z "$length" ]; then
  echo -e "error: length was not specified"
  print_help
  exit 1
fi

# If it was specified neither as argument, nor as an environment variable
if [ -z "$width" ]; then
  echo -e "error: width was not specified"
  print_help
  exit 1
fi

# regexp that matches optional sign symbol, then some number with at least 1 digit
number_regexp='^[+-]?[0-9]+$'
# it is what it is
if ! [[ $length =~ $number_regexp ]]; then
   echo -e "error: specified length is not a number"
   exit 1
fi
# it is what it is
if ! [[ $width =~ $number_regexp ]]; then
   echo -e "error: specified width is not a number"
   exit 1
fi

# check positiveness of length using function is_positive that was defined earlier
if ! is_positive $length; then
  echo -e "error: specified length isn't a positive number"
  exit 1
fi
# check positiveness of width using function is_positive that was defined earlier
if ! is_positive $width; then
  echo -e "error: specified width isn't a positive number"
  exit 1
fi

# it is what it is, use $ to convert to string output
perimeter=$((2 * ($length + $width)))

echo "$perimeter" > out.txt

exit 0
