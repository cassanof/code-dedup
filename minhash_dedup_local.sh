#!/bin/bash
# ./minhash_dedup_hf.sh <input_repo> <output_repo> <content_col> <threshold>

if [ $# -lt 1 ]; then
    echo "Usage: ./minhash_dedup_hf.sh <input_repo> <output_repo, optional> <content_col, optional> <threshold, optional>"
    exit 1
fi

input_repo=$1
# default to input_repo
output_repo=${2:-$input_repo}
# default to "content"
content_col=${3:-content}
# default to 0.5
threshold=${4:-0.5}

echo "Running minhash deduplication with the following parameters:"
echo "input_repo: $input_repo"
echo "output_repo: $output_repo"
echo "content_col: $content_col"
echo "threshold: $threshold"

python -m text_dedup.minhash \
  --path $input_repo \
  --split "train" \
  --local \
  --output $output_repo \
  --column "$content_col" \
  --batch_size 10000 \
  --threshold $threshold \
  --num_perm 500
