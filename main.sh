#/bin/sh

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


_print_usage() {
  echo "usage: $(basename $0) [--version] [--help]"
}

# read the options
OPTS=$(getopt -o '' --long version,help -n "$0" -- "$@")
if [ $? != 0 ]; then
  exit 1
fi
eval set -- "$OPTS"

while true; do
  case "$1" in
    --version) . .version; echo "$(basename $0) version ${VERSION}"; exit 0;;
    --help) _print_usage; exit 0;;
    --) shift; break;;
    *) echo "Error: option not handled by script"; exit 1;;
  esac
done

echo "do something"

