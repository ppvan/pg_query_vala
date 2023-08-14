#!/bin/bash

set -e

build_dir=build
out_dir=lib

echo "build_dir: $build_dir"
echo "out_dir: $out_dir"

if [ -d "$build_dir/libpg_query" ]; then
    echo "libpg_query already built."
    exit 0
else
    echo "Building libquery."
fi

git clone --depth 1 --branch 15-4.2.3 https://github.com/pganalyze/libpg_query.git $build_dir/libpg_query

# cd libpg_query

make -C $build_dir/libpg_query build

cp $build_dir/libpg_query/libpg_query.a $out_dir/libpg_query.a
cp $build_dir/libpg_query/pg_query.h $out_dir/pg_query.h

# cp libpg_query/pg_query.h ../libpg_query/pg_query.h