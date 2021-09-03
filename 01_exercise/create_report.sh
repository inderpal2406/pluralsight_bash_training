#!/usr/bin/env bash

# This script will process data in data.csv and will generate a report as report.txt.
# The report will have data of products available in single container.
# The script will initially display all available container ids.
# Then user can provide the desired container id as an input.
# Then the script will generate the report.txt file for the desired container id.
# Author: Inderpal Singh
# Date: 3 September, 2021


# Script begins here.

# Clear the screen.

clear

# Display prupose of script.

echo "This script will ask for container id as input and generate report of products for the entered container id."
echo

# Check if report.txt already exists from previous execution. If yes, then delete it.

if [ -f ./report.txt ]
then
	rm -f ./report.txt
fi

# Read through data.csv and consolidate all container ids into a variable.

container_ids=$(tail +2 ./data.csv | cut -d ',' -f 2 | sort -u)

# Display the container ids and ask for user input.

echo			# Display blank line for good look.
echo "Container IDs:"
echo $container_ids
echo 
read -p "Enter the container ID (input is case sensitive): " container_id
echo

# Initialize the report.

touch ./report.txt
echo "The products in the container $container_id are as below:" > ./report.txt

# Process data.csv and generate report of products in desired container_id.

grep -w $container_id ./data.csv | cut -d ',' -f 3 >> ./report.txt

# Check if valid container id was provided in user input. Display message accordingly.

count=$(wc -l ./report.txt | awk '{print $1}')
if [ $count -eq 1 ]
then
	echo "Report is generated but the entered container id is invalid. No products were found for this container id."
	echo "Please enter correct container id on next run."
	echo
else
	echo "Report is successfully generated in path ./report.txt."
        echo "Please view the report to view the products for the container id."
	echo
fi

# End of script.

