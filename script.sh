#!/bin/bash

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <build_dir> <src_dir>"
    exit 1
fi


build_dir=$1
src_dir=$2

echo "build_dir: $build_dir"
echo "src_dir: $src_dir"

# If rsync is found using rsync 
if command -v rsync &> /dev/null
then
    echo "rsync found"
    rsync -a $src_dir/libpg_query $build_dir
else
    echo "rsync not found"
    cp -r $src_dir/libpg_query $build_dir
fi

make -C $src_dir/libpg_query build

# Copy the library to build root so meson can find it
cp $build_dir/libpg_query/libpg_query.a $build_dir/libpg_query.a
# cp $build_dir/libpg_query/libpg_query.a $src_dir/libpg_query.a

# cp libpg_query/pg_query.h ../libpg_query/pg_query.h