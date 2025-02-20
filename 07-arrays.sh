#!bin/bash

MOVIES=("pushpa" "devara" "rrr")
#Array's index starts from '0'. Size is 3

echo "First movie is ${MOVIES[0]}"
echo "Second movie is ${MOVIES[1]}"
echo "Third movie is ${MOVIES[2]}"

echo "All movies are ${MOVIES[@]}"  # '@' means ALL
echo "Movies names are: ${MOVIES}"
echo "The second movie is NNTR's ${MOVIES[1]}" 