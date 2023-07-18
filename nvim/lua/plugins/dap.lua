vim.g.dotnet_build_project = function()
  local default_path = vim.fn.getcwd() .. "/"
  if vim.g["dotnet_last_proj_path"] ~= nil then
    default_path = vim.g["dotnet_last_proj_path"]
  end
  local path = vim.fn.input("Path to your *proj file", default_path, "file")
  vim.g["dotnet_last_proj_path"] = path
  local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
  print("")
  print("Cmd to execute: " .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    print("\nBuild: ✔️ ")
  else
    print("\nBuild: ❌ (code: " .. f .. ")")
  end
end

vim.g.dotnet_get_dll_path = function(type)
  local request = function()
    return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
  end

  local key = "dotnet_last_dll_path" + "_" + type

  if vim.g[key] == nil then
    vim.g[key] = request()
  else
    if vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g[key], "&yes\n&no", 2) == 1 then
      vim.g[key] = request()
    end
  end

  return vim.g["dotnet_last_dll_path" + "_" + type]
end

local config = {
  {
    type = "coreclr",
    name = "launch - enter path",
    request = "launch",
    program = function()
      if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
        vim.g.dotnet_build_project()
      end
      return vim.g.dotnet_get_dll_path("enter_path")
    end,
  },
  {
    type = "coreclr",
    name = "attach - kuika -- core_api",
    request = "attach",
    processId = function()
      return vim.fn.input("Process Id ")
    end,
    program = function()
      return "/Users/ilyasakin/kuika-component-library-designer/Backend/CoreApi/bin/Mac/net6.0/Kuika.Services.CoreApi.dll"
    end,
  },
}

local dap = require("dap")

dap.configurations.cs = config
dap.configurations.fsharp = config

return {}
