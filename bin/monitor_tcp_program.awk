# >2 to skip header
NR > 2 {
  portpos=match($5, /[0-9]*$/)
  host=substr($5, 0, portpos - 2)
  "dig -x " host | getline x
  # x=system("dig -x " host " +short 2> /dev/null")
  #print $4,$5,x,$6
}
