
function explorer() {
  vartemppath=`pwd`
  vartemppath=$(sed 's/\//\\\\/g' <<<"$vartemppath")

  #fails on the concat, I can't figure out why
  explorer.exe "$WSLENV$vartemppath"
}