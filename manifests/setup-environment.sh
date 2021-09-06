#!/bin/sh

# Inspired by "probe" in oe-init-build-env
if [ -n "$BASH_SOURCE" ]; then
    this_script=$BASH_SOURCE
elif [ -n "$ZSH_NAME" ]; then
    this_script=$0
else
    this_script="$(pwd)/setup-environment"
fi

app=""
apps=(
    "calllogger"
)

for i in ${apps[@]}
do
    if [[ $i == $1 ]]
    then
        app=$1
        break
    fi
done

if [ -z "${app}" ]; then
    echo "Sorry, it does not seem that *$1* is a valid app"
    echo ""

    printf "Supported apps are:\n"
    printf '%s\n' "${apps[@]}"
    return 1
fi

script_dir=$(dirname "$this_script")
script_dir=$(readlink -f "$script_dir")
quartx_dir=${script_dir}/layers/meta-quartx
build_dir=${script_dir}/build

target_file=${script_dir}/.target
target=$(cat "$target_file")

if [ ! -f ${target_file} ]; then
    echo "Sorry, it does not seem that *target* is valid"
    echo ""
    return 1
fi

# Initialize bitbake
. ${script_dir}/layers/poky/oe-init-build-env ${build_dir}

# Always update bblayers
target_templates=${quartx_dir}/manifests/${target}/templates
cp -f ${target_templates}/bblayers.conf.sample ${build_dir}/conf/bblayers.conf

# Only append conf if not marked complete
if [ ! -f ${build_dir}/conf/append_complete ]; then
    # Common conf
    cat ${quartx_dir}/manifests/common/conf.append >> ${build_dir}/conf/local.conf

    # Board specific conf
    cat ${target_templates}/local.conf.append >> ${build_dir}/conf/local.conf

    # Mark complete
    touch ${build_dir}/conf/append_complete
fi

case $app in
  calllogger)
    bitbake-layers add-layer ../layers/meta-quartx/meta-quartx-calllogger
    ;;

  *)
    echo "unknown"
    ;;
esac
