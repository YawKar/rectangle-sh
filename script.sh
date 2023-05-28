#!/bin/bash

# Вывод справки
print_help() {
  echo "Usage example:"
  echo "  ./script.sh -l <length> -w <width>"
  echo ""
  echo "Args:"
  echo "  -l <length>   length of the rectangle"
  echo "  -w <width>    width of the rectangle"
  echo ""
}

# Вспомогательная функция для проверки числа на положительность
is_positive() {
  local number=$1
  if [ $number -gt 0 ]; then
    return 1
  else
    return 0
  fi
}

while getopts 'l:w:h' opt; do
  case "$opt" in
    l)
      length=$OPTARG
      echo "Processing option 'l' with '${OPTARG}' argument"
      ;;
    w)
      width=$OPTARG
      echo "Processing option 'w' with '${OPTARG}' argument"
      ;;
    ?|h)
      print_help
      exit 1
      ;;
  esac
done



