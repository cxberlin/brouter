#!/bin/bash

mkdir -p data/segments
cd data/segments
wget -r --no-parent --reject "index.html*" -e robots=off -nH --cut-dirs=2 http://brouter.de/brouter/segments4/
