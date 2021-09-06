#!/bin/sh

# Inspired by "probe" in oe-init-build-env
if [ -n "$BASH_SOURCE" ]; then
    this_script=$BASH_SOURCE
elif [ -n "$ZSH_NAME" ]; then
    this_script=$0
else
    this_script="$(pwd)/setup-environment"
fi

target=""
targets=(
    "raspberrypi3"
    "raspberrypi4"
)

for i in ${targets[@]}
do
    if [[ $i == $1 ]]
    then
        target=$1
        break
    fi
done

if [ -z "${target}" ]; then
    echo "Sorry, it does not seem that *$1* is a valid target"
    echo ""

    printf "Supported targets are:\n"
    printf '%s\n' "${targets[@]}"
    return 1
fi

script_dir=$(dirname "$this_script")
script_dir=$(readlink -f "$script_dir")
quartx_dir=${script_dir}/layers/meta-quartx
build_dir=${script_dir}/build

# Initialize bitbake
. ${script_dir}/layers/poky/oe-init-build-env ${build_dir}

# Always update bblayers
target_templates=${quartx_dir}/manifests/${target}/templates
cp ${target_templates}/bblayers.conf.sample ${build_dir}/conf/bblayers.conf

# Only append conf if not marked complete
if [ ! -f ${build_dir}/conf/append_complete ]; then
    # Common conf for Mender
    cat ${quartx_dir}/manifests/common.conf.append >> ${build_dir}/conf/local.conf

    # Board specific conf
    cat ${target_templates}/local.conf.append >> ${build_dir}/conf/local.conf

    # Mark complete
    touch ${build_dir}/conf/append_complete
fi
