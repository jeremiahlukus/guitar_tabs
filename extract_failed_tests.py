import os
import re

if os.path.exists('test_results.txt'):
    with open('test_results.txt', 'r') as file:
        data = file.read()

    failed_tests = re.findall(r'The following TestFailure was thrown running a test:(.*?Which:.*?)\n', data, re.DOTALL)

    with open('failed_tests.txt', 'w') as file:
        for i, test in enumerate(failed_tests, start=1):
            file.write(f'# {i} FAILURE\n{test.strip()}\n\n')
        file.write(f'Total failures: {len(failed_tests)}\n')