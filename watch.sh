#/bin/sh

pushd themes/hyde/compass
compass watch &
popd

hugo server -w &
