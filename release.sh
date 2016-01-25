#!/usr/bin/env bash

# Copyright (c) 2015 Philipp Grogg
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See LICENSE file for more details.


_is_git_dirty() {
  echo $(git status --porcelain |grep -v "^??" |tail -n1 |wc -l)
}

_git_dirty_check() {
  if [ $(_is_git_dirty) = 1 ]; then
    echo "There are local uncommited changes!"
    echo "Please, commit your changes or stash them before you can prepare a release."
    echo "Aborting"
    exit 1
  else
    echo "all fine"
  fi
}

_increment_version_number() {
  echo $1 | perl -pe 's/^((\d+\.)*)(\d+)(.*)$/$1.($3+1).$4/e'
}

_create_new_version() {
  . .version
  echo "Version is: ${VERSION}"
  read -e -p "Enter the new version: " -i "$(_increment_version_number ${VERSION})" VERSION
  echo "New version is: ${VERSION}"
  echo "VERSION=${VERSION}" > .version
  git add .version
  git commit -m "New release ${VERSION}"
  git tag -a ${VERSION} -m "New release ${VERSION}"
  git push --follow-tags
}

_prepare() {
  _git_dirty_check
  _create_new_version
}

_print_usage() {
  echo "usage: $(basename $0) <command>"
  echo ""
  echo "These are the supported commands:"
  echo "   prepare      Prepare a release"
}

# read the options
OPTS=$(getopt -o '' --long help -n "$0" -- "$@")
if [ $? != 0 ]; then
  exit 1
fi
eval set -- "$OPTS"

while true; do
  case "$1" in
    --help) _print_usage; exit 0;;
    --) shift; break;;
    *) echo "Error: option not handled by script"; exit 1;;
  esac
done

case "$1" in
  prepare) _prepare;;
  *) _print_usage; exit 0;;
esac

