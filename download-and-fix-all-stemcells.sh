#!/bin/sh

###
###  Will look at all stemcells and try to re-download and fix them all
###

STEMCELLS=$(bosh stemcells | awk -F'|' '/bosh-/ {gsub(/[^0-9a-zA-Z\-_]/,"",$2); gsub(/[^0-9\.]/,"",$4); st = index($2,"-"); print substr($2,0,st) "stemcell-" $4 "-" substr($2,st+1) ".tgz";}');

# echo -e "Found stemcells: \n\n${STEMCELLS} \n\n"

for I in $STEMCELLS; do
    echo "Downloading $I ..." && bosh download public stemcell $I && echo "Uploading and fixing stemcell $I ... " && bosh upload stemcell $I --fix
done

exit 0
