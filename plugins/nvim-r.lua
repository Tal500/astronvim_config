return {
  "jalvesaq/Nvim-R",
  enabled = true,
  name = "nvim-r",
  ft = function(plugin, ft)
    local function contains(table, val)
      for k,v in ipairs(table) do
        if k == val then
          return true
        end
      end
      return false
    end

    local function load(subpath)
      vim.cmd("source " .. plugin.dir .. "/ftplugin/" .. subpath .. ".vim")
    end
    
    if contains(ft, "r") then
      load("r_nvimr")
    elseif contains(ft, "quarto") then
      load("quarto_nvimr")
    elseif contains(ft, "rhelp") then
      load("rhelp_nvimr")
    elseif contains(ft, "rmd") then
      load("rmd_nvimr")
    end

    -- Anyway, this function needs to return the supported file types to register for loading
    return {"r", "quarto", "rhelp", "rmd"}
  end,
}
