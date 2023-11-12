import os
import re

if os.path.exists('test_results.txt'):
    with open('test_results.txt', 'r') as file:
        data = file.read()

    failed_tests = re.findall(r'FAILED: .+', data)

    with open('failed_tests.txt', 'w') as file:
        for test in failed_tests:
            file.write(test + '\n')
