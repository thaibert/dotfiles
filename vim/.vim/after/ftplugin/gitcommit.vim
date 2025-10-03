let this_script_path = expand('<script>:p')
for file in split(glob(this_script_path . ".d/*"), '\n')
  "echomsg "sourcing '" . file . "'"
  execute "source " . file
endfor
