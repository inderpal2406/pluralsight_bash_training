#!/usr/bin/env -S bash -v
# -v option for bash will print script lines as they are read.

# This script will process data in data.csv and will generate a report as container_id.csv file.
# The report will have data of products available in single container.
# The script will initially display all available container ids.
# Then user can provide the desired container id as an input.
# Then the script will generate the report.txt file for the desired container id.
# This sript is same as 02_exercise, but makes bash debugging options.
# Author: Inderpal Singh
# Date: 3 September, 2021


# Script begins here.

# Clear the screen.

clear

# Display prupose of script.

echo "This script will ask for container id as input and generate report of products for the entered container id."
echo

# Initialize variable

directory="./reports"

# Read through data.csv and consolidate all container ids into a variable.

container_ids=$(tail +2 ./data.csv | cut -d ',' -f 2 | sort -u)

# Display the container ids and ask for user input.

echo			# Display blank line for good look.
echo "Container IDs:"
echo $container_ids
echo 
read -p "Enter the container ID (input is case sensitive): " container_id
echo

# Initialize variable

report_name="$container_id.csv"

# Create directory to hold output reports.

mkdir -p $directory	# -p flag will ensure error is not thrown if directory already exists from previous execution.

# Initialize the report.

head -1 ./data.csv > $directory/$report_name

# Process data.csv and generate report of products in desired container_id.

grep -w $container_id ./data.csv >> $directory/$report_name

# Check if valid container id was provided in user input. Display message accordingly.

count=$(wc -l $directory/$report_name | awk '{print $1}')
if [ $count -eq 1 ]
then
	echo "Report is generated but the entered container id is invalid. No products were found for this container id."
	echo "Please enter correct container id on next run."
	echo "Deleting the wrong report."
	rm -f $directory/$report_name
	echo
else
	echo "Report is successfully generated in path $directory/$report_name"
        echo "Please view the report to view the products for the container id."
	echo
fi

# End of script.

