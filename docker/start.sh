#!/bin/sh

python /template.py /config/config.yaml.j2 config.yaml

/transform-data
