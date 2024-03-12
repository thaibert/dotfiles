#!/usr/bin/zsh

MAX_IMAGE_LENGTH=30

docker container ps --format "json" |
  jq "to_entries | map({key: .key, value: (if (.key == \"Image\") and ((.value | length) > $MAX_IMAGE_LENGTH) then \"...\" + .value[-$MAX_IMAGE_LENGTH:] else .value end)} ) | from_entries
  " |
  jq --slurp '.[] | [.ID, .Names, .Status, .Image]' |
  jq --slurp '. | [["ID", "CONTAINER NAME", "STATUS", "IMAGE"]] + .' |
  jq --raw-output '.[] | @tsv' | 
  column -t -s $'\t'  |
  sort --key="2" # Columns are indexed as (1, 2, ...), so sort on container_name
