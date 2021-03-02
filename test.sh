#!/bin/bash

attendu=`tail -n 2 ~/Scrum-test_Project/questions/4`

read -p "saisie : " rep

if [ $rep = $attendu ]
then
	echo "idem"
else
	echo "pas bon"
fi
