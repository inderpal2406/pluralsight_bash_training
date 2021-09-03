#!/usr/bin/env bash 

# This script will process data in data.csv and will generate a report as container_id.csv file.
# The report will have data of products available in single container.
# The script will accept container id and destination folder as command line arguments.
# Then the script will generate the container_id.csv file for the desired container id.
# This sript is same as 03_exercise, but makes use of bash command line arguments.
# Author: Inderpal Singh
# Date: 3 September, 2021


# Script begins here.

# Clear the screen.

clear

# Display prupose of script.

echo "This script will accept container id and output directory as CLI arguments."
echo "It then generates report of products for the entered container id in entered output directory."
echo
echo "Correct execution: ./create_report.sh container_id output_directory"
echo "For example: ./create_report.sh H2 reports"
echo

# Check if required number of arguments are received at command line. If not then exit.

if [ $# -ne 2 ]
then
	echo "Required arguments are not passed at command line."
	echo "Please enter required arguments in correct format as per the example above on next run."
	echo "Exiting script now."
	echo
	exit 1
fi

# Initialize variable

container_id=$1
directory=$2
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

