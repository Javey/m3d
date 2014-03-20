#!/bin/bash

LANG="zh_CN.UTF-8"
export SVNFE="/home/bae/local/subversion/bin/svn --config-dir /home/bae/.svn-ci";
export SVNRD="/home/bae/local/subversion/bin/svn --config-dir /home/bae/.svn-ci";
BASE_DIR="/home/bae/music"

SRC_DIR="$BASE_DIR/src";
BRANCH_DIR="$SRC_DIR/branches";
TRUNK_DIR="$SRC_DIR/trunk";

RD_BRANCH_DIR="$BRANCH_DIR/rd";
FE_BRANCH_DIR="$BRANCH_DIR/fe";

RD_TRUNK_DIR="$TRUNK_DIR/rd";
FE_TRUNK_DIR="$TRUNK_DIR/fe";

#分支模版文件夹
BRANCH_TEMPLATE_NAME="branch-template";

function die {
	echo "$1" >&2;
	exit -1;
}
