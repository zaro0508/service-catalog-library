#!/bin/bash
shopt -s nullglob
mkdir templates/
cp {ec2,vpc}/*.yaml templates/
cp codepipeline/*.yaml templates/
for f in templates/*; do
    if cfn_nag_scan --input-path "$f" --blacklist-path ./codepipeline/blacklist-cfnnag.yaml; then
        echo "$f PASSED"
    else
        echo "$f FAILED"
        touch FAILED
    fi
done

if [ -e FAILED ]; then
  echo cfn-nag FAILED at least once!
  exit 1
else
  echo cfn-nag PASSED on all files!
  exit 0
fi
