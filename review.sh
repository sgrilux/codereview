#!/bin/bash
# 
# This script clone a repository in a temporary folder.
# ArgumentsÖ
#  - repository URL
#  - branch name
#

MAIN_BRANCH=master

set -eou pipefail

function usage() {
  cat << __EOF__
    Usage: $0 <repository_url> <branch>
__EOF__
}

function validate_repo() {
  [[ $1 =~ ((git|ssh|https)|(git@[\w\.]+)):((\/\/)?)([\w\.@\:\/\-~]+)(\.git)(\/)? ]] && return 0 || return 1
}

function branch_exist() {
  git show-ref -q remotes/origin/$1 && return 0 || return 1

}

function continue() {
  echo
  read -p "Press enter to continue"
  echo
}

function is_dir_empty() {
  [ "$(ls -A $1)" ] && return 1 || return 0
}

[[ $# < 2 ]] && usage && exit 10

repo=$1
branch=$2

! validate_repo ${repo} && echo "Please provide a valid git repository url!" && exit 20

repo_name=$(echo ${repo##*/}|cut -d'.' -f1)
repo_dir=.repo/${repo_name}
mkdir -p ${repo_dir}

echo "Repository already exist...pulling updates"
if [ -d ${repo_dir} ] && ! is_dir_empty ${repo_dir}; then
  cd ${repo_dir}
  git checkout ${MAIN_BRANCH}
  git pull
else
  echo "Cloning repo ${repo} into ${repo_dir}..."
  git clone -q ${repo} ${repo_dir}
  cd ${repo_dir}
fi

echo

! branch_exist ${branch} && echo "Branch provided does not exists!" && exit 30

echo "Running tflint..."
tflint $(git diff --name-only --diff-filter=ACMR origin/${branch}...${MAIN_BRANCH} -- *.ts)

continue

echo "Running shellcheck..."
shellcheck $(git diff --name-only --diff-filter=ACMR origin/${branch}...${MAIN_BRANCH} -- *.sh)

continue

