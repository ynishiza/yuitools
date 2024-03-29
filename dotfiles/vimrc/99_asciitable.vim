let g:yt_asciitables = [
\ { "value": 0, "label": "NUL \\0" },
\ { "value": 1, "label": "SOH" },
\ { "value": 2, "label": "STX" },
\ { "value": 3, "label": "ETX" },
\ { "value": 4, "label": "EOT" },
\ { "value": 5, "label": "ENQ" },
\ { "value": 6, "label": "ACK" },
\ { "value": 7, "label": "Bell \\a" },
\ { "value": 8, "label": "Backspace \\b" },
\ { "value": 9, "label": "Tab \\t" },
\ { "value": 10, "label": "Newline \\n" },
\ { "value": 11, "label": "Vertical tab \\v" },
\ { "value": 12, "label": "Feedforward \\f" },
\ { "value": 13, "label": "CR \\r" },
\ { "value": 14, "label": "SO" },
\ { "value": 15, "label": "SI" },
\ { "value": 16, "label": "DLE" },
\ { "value": 17, "label": "DC1" },
\ { "value": 18, "label": "DC2" },
\ { "value": 19, "label": "DC3" },
\ { "value": 20, "label": "DC4" },
\ { "value": 21, "label": "NAK" },
\ { "value": 22, "label": "SYN" },
\ { "value": 23, "label": "ETB" },
\ { "value": 24, "label": "CAN" },
\ { "value": 25, "label": "EM" },
\ { "value": 26, "label": "SUB" },
\ { "value": 27, "label": "ESC" },
\ { "value": 28, "label": "FS" },
\ { "value": 29, "label": "GS" },
\ { "value": 30, "label": "RS" },
\ { "value": 31, "label": "US" },
\ { "value": 32, "label": "SPACE" },
\ { "value": 33, "label": "" },
\ { "value": 34, "label": "" },
\ { "value": 35, "label": "" },
\ { "value": 36, "label": "" },
\ { "value": 37, "label": "" },
\ { "value": 38, "label": "" },
\ { "value": 39, "label": "" },
\ { "value": 40, "label": "" },
\ { "value": 41, "label": "" },
\ { "value": 42, "label": "" },
\ { "value": 43, "label": "" },
\ { "value": 44, "label": "" },
\ { "value": 45, "label": "" },
\ { "value": 46, "label": "" },
\ { "value": 47, "label": "" },
\ { "value": 48, "label": "" },
\ { "value": 49, "label": "" },
\ { "value": 50, "label": "" },
\ { "value": 51, "label": "" },
\ { "value": 52, "label": "" },
\ { "value": 53, "label": "" },
\ { "value": 54, "label": "" },
\ { "value": 55, "label": "" },
\ { "value": 56, "label": "" },
\ { "value": 57, "label": "" },
\ { "value": 58, "label": "" },
\ { "value": 59, "label": "" },
\ { "value": 60, "label": "" },
\ { "value": 61, "label": "" },
\ { "value": 62, "label": "" },
\ { "value": 63, "label": "" },
\ { "value": 64, "label": "" },
\ { "value": 65, "label": "" },
\ { "value": 66, "label": "" },
\ { "value": 67, "label": "" },
\ { "value": 68, "label": "" },
\ { "value": 69, "label": "" },
\ { "value": 70, "label": "" },
\ { "value": 71, "label": "" },
\ { "value": 72, "label": "" },
\ { "value": 73, "label": "" },
\ { "value": 74, "label": "" },
\ { "value": 75, "label": "" },
\ { "value": 76, "label": "" },
\ { "value": 77, "label": "" },
\ { "value": 78, "label": "" },
\ { "value": 79, "label": "" },
\ { "value": 80, "label": "" },
\ { "value": 81, "label": "" },
\ { "value": 82, "label": "" },
\ { "value": 83, "label": "" },
\ { "value": 84, "label": "" },
\ { "value": 85, "label": "" },
\ { "value": 86, "label": "" },
\ { "value": 87, "label": "" },
\ { "value": 88, "label": "" },
\ { "value": 89, "label": "" },
\ { "value": 90, "label": "" },
\ { "value": 91, "label": "" },
\ { "value": 92, "label": "" },
\ { "value": 93, "label": "" },
\ { "value": 94, "label": "" },
\ { "value": 95, "label": "" },
\ { "value": 96, "label": "" },
\ { "value": 97, "label": "" },
\ { "value": 98, "label": "" },
\ { "value": 99, "label": "" },
\ { "value": 100, "label": "" },
\ { "value": 101, "label": "" },
\ { "value": 102, "label": "" },
\ { "value": 103, "label": "" },
\ { "value": 104, "label": "" },
\ { "value": 105, "label": "" },
\ { "value": 106, "label": "" },
\ { "value": 107, "label": "" },
\ { "value": 108, "label": "" },
\ { "value": 109, "label": "" },
\ { "value": 110, "label": "" },
\ { "value": 111, "label": "" },
\ { "value": 112, "label": "" },
\ { "value": 113, "label": "" },
\ { "value": 114, "label": "" },
\ { "value": 115, "label": "" },
\ { "value": 116, "label": "" },
\ { "value": 117, "label": "" },
\ { "value": 118, "label": "" },
\ { "value": 119, "label": "" },
\ { "value": 120, "label": "" },
\ { "value": 121, "label": "" },
\ { "value": 122, "label": "" },
\ { "value": 123, "label": "" },
\ { "value": 124, "label": "" },
\ { "value": 125, "label": "" },
\ { "value": 126, "label": "" },
\ { "value": 127, "label": "DEL" }
\ ]
function! YT_Asciitable()
  let l:length = len(g:yt_asciitables)
  let l:ncolumns = 4
  let l:nrows = float2nr(ceil(l:length / l:ncolumns))
  let l:output = ""
  for r in range(0, l:nrows - 1)
    for c in  range(0, ncolumns - 1)
      let l:i = r + c * l:nrows
      let l:entry = g:yt_asciitables[l:i]
      let l:label = entry["label"] == "" ? nr2char(entry["value"]) : entry["label"]
      let l:output .= printf("%d 0x%02x %-20s\t", entry["value"], entry["value"], l:label)
    endfor
    let l:output .= "\n"
  endfor
  echo output
endfunction

:command! -nargs=0 YTAsciitable call YT_Asciitable()
