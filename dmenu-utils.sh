# descend into the subdirectories below
function d {
  cd $(find . -type d 2>/dev/null | dmenu -i -p '>' -l 10)
}

# ascend to the directories directly above you
# has a known flaw: if 2 anscestors have the same name, defaults to the one higher on the tree
function a {
  path=$(pwd | tr '/' ' ')
  dest=$(for i in $path; do echo $i; done | tac | dmenu -i -p '<')
  cd "$(echo $(pwd) | awk -F"/$dest" '{print $1}')/$dest"
}

# grep utils
# open the result of a numbered grep command in vi using dmenu
# basically, grep anything with line numbers enabled and pipe it to vo
alias vo="cat | dmenu -i -p 'vo' -l 25 | awk -F: '{print \"+\"\$2,\$1}' | xargs sh -c 'vim "\$@" < /dev/tty' vim"

# select file to complete 
db-select() {
  local cmd="command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"
  #local cmd="find -L ."
  eval "$cmd" | dmenu -l 10 -i -p "bash"
  echo
}

# handle the readline prompt
db-file-widget() {
  local selected="$(db-select)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

# file complete in bash
bind -x '"\C-t": "db-file-widget"'
