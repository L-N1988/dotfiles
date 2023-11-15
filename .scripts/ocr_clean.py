import sys
import re
import pandas as pd

# 读取输入的文本
input_text = sys.stdin.read()
regex = r'(?<=\b\w\b) +(?=\b\w\b)'
print(re.sub(regex, '', input_text))

