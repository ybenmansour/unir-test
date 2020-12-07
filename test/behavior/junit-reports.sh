#!/bin/bash

for file in $(ls results/*features*.xml);
do
    junit2html $file
done
