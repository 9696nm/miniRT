#/usr/bin/env bash

if [ $# -gt 0 ]; then
	valgrind --leak-check=full -q ./miniRT "$@"
else
	valgrind --leak-check=full -q ./miniRT test_maps/basic.rt
fi