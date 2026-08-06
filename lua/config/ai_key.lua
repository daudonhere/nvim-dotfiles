local M = {}

local function extract_from_file(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  for line in f:lines() do
    local key = line:match('MINUET_API_KEY%s*=%s*["\']?([%w%-]+)["\']?')
    if key and key ~= "" then
      f:close()
      return key
    end
  end
  f:close()
  return nil
end

function M.get()
  local key = os.getenv("MINUET_API_KEY")
  if type(key) == "string" and key ~= "" then
    return key
  end
  local home = os.getenv("HOME")
  return extract_from_file(home .. "/.zshrc") or extract_from_file(home .. "/.bashrc")
end

return M
