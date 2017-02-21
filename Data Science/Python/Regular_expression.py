#this program returs the sum of all the numbers in a text file

import re

sum = 0

file = open('regex_test_file.txt', 'r')
for line in file:
    numbers = re.findall('[0-9]+', line)
    if not numbers:
        continue
    else:
        for number in numbers:
            sum += int(number)

print(sum)
