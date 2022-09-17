-- Reference: https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value
table.copy = function(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end
