import pandas as pd
import numpy as np

# Load file
df = pd.read_csv("big_file.csv")

# Split into 10 chunks (this will split the big file into 10 files)
chunks = np.array_split(df, 10)

# Save each chunk
for i, chunk in enumerate(chunks):
    chunk.to_csv(f"big_file{i+1}.csv", index=False)
