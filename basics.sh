#!/bin/bash

a=4
b=10

# conditions

if [ $a > $b ]
then
	echo "a is greater than b"
else
	echo "b is greater than a"
fi

#loop  -> for, while, until

for i in {1..5}; do
	echo "$i"
done

