-- Source: https://stackoverflow.com/a/72666170/2968864
function escape(s)
    return (s:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]','%%%1'))
end

local function contains(table, val)
  for k,v in ipairs(table) do
    if k == val then
      return true
    end
  end
  return false
end

-- Source: https://stackoverflow.com/a/11671820/2968864
function map(tbl, f)
  local t = {}
  for k,v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end

return {
  "jalvesaq/Nvim-R",
  enabled = true,
  name = "nvim-r",
  init = function(plugin)
    vim.cmd("source " .. plugin.dir .. "/ftdetect/r.vim")
  end,
  ft = function(plugin, ft)
    local function load(subpath)
      vim.cmd("source " .. plugin.dir .. "/ftplugin/" .. subpath .. ".vim")
    end

    local ftplugins_path = vim.split(vim.fn.glob(plugin.dir .. "/ftplugin/*.vim"), "\n")
    local ftplugins = map(ftplugins_path,
      function(path)
        return {
          filetype = string.match(path, escape(plugin.dir) .. "/ftplugin/(%w+)[(_nvim)]?.vim"),
          path = path,
        }
      end
    )
    
    for k, ftplugin in ipairs(ftplugins) do
      if contains(ft, ftplugin.filetype) then
        vim.cmd("source " .. ftplugins.path)
      end
    end

    -- Anyway, this function needs to return the supported file types to register for loading
    return map(ftplugins,
      function(ftplugin)
        return ftplugin.filetype
      end
    )
  end,
}
