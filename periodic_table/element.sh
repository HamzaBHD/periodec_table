#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else
if [[ ! $1 =~ ^[0-9]+$ ]]
then 
ELEMENTS=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
else
ELEMENTS=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
fi
if [[ -z $ELEMENTS ]]
then
echo "I could not find that element in the database."
else
echo "$ELEMENTS"| while read TYPE_ID BAR NUM BAR SYM BAR NAME BAR MASS BAR MPC BAR BPC BAR TYPE
do
echo "The element with atomic number $NUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
done
fi
fi