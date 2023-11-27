#!/bin/bash
# ./minhash_dedup_hf.sh <input_repo> <output_repo> <content_col> <threshold>

if [ $# -lt 2 ]; then
    echo "Usage: ./minhash_dedup_hf.sh <input_repo> <output_repo> <content_col, optional> <threshold, optional>"
    exit 1
fi

input_repo=$1
output_repo=$2
# default to "content"
content_col=${3:-content}
# default to 0.5
threshold=${4:-0.5}

python -m text_dedup.minhash \
  --path $input_repo \
  --split "train" \
  --output $output_repo \
  --column "$content_col" \
  --batch_size 10000 \
  --threshold $threshold \
  --num_perm 500 \
  --push
