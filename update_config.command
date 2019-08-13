#!/bin/bash -eu

BASE_NAME=$(basename $0)
DIR_NAME=$(cd $(dirname $0) ; pwd)

configs_tar='configs.tar'

if [ ! -f ${configs_tar} ]; then
	echo "configs.tarがありません"
	exit 1
fi

for files in $(tar tf ${configs_tar})
do
	target=$(echo ${files} | cut -d'/' -f2)
	if [[ ! -z ${target} ]] && [[ -e ${DIR_NAME}/${target} ]]; then
		rm -rf ${DIR_NAME}/${target}
	fi
done

tar xvf ${configs_tar}
