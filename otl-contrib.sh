#!/usr/bin/zsh

#set some vars
export WORKDIR=$HOME/git/repo/opentelemetry-collector-contrib

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

abort_func(){
  errorfunction=$1

  echo "${RED}Error:${NC} exiting $errorfunction"
  exit 1
}

make_function() {
	function=$1

	echo "\nstarting make $function:\n"
	make $function || abort_func $function
	echo -e "\n${GREEN}make $function successfully done${NC}"
}

### main body

if [ !$CGO_ENABLED ]; then
  CGO_ENABLED=1
  echo "CGO_ENABLED set to $CGO_ENABLED"
fi
cd $WORKDIR || exit
echo "WORKDIR set to $WORKDIR"
make_function checkdoc
make_function checkmetadata
make_function checkapi
make_function goporto
make_function crosslink
make_function gotidy
make_function genotelcontribcol
make_function genoteltestbedcol
make_function generate
make_function multimod-verify
make_function generate-gh-issue-templates
echo "\neverything is set up for PR"
