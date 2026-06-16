import pandas as pd
import numpy as np
import zipfile

input_file = 'big_file.csv'
df = pd.read_csv(input_file)

chunks = np.array_split(df, 50)
file_names = []

for i, chunk in enumerate(chunks, start=1):
    fname = f'big_file_part{i}.csv'
    chunk.to_csv(fname, index=False)
    file_names.append(fname)

zip_name = 'big_file_split_50.zip'
with zipfile.ZipFile(zip_name, 'w') as z:
    for f in file_names:
        z.write(f)

zip_name
