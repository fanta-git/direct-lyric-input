local DIR_NAME = "direct-lyric-input"
local OUTPUT_DIR_NAME = "output"
local TEMPLATES_DIR_NAME = "templates"
local MODULES_DIR_NAME = "modules"
local TEMPLATE_FILE_EXT = ".txt"
local INPUT_TEMPLATE = "input"
local OTHER_TEMPLATES = { "lyricClear", "lyricClearAll" }
local PATH_SETS = {
  Windows = {
    default = "C:\\User\\username\\Documents\\Dreamtonics\\Synthesizer V Studio\\scripts",
    sep = "\\"
  },
  macOS = {
    default = "/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts",
    sep = "/"
  },
  Linux = {
    default = "",
    sep = "/"
  },
  Unknown = {
    default = "",
    sep = "/"
  }
}

---@type { KEY: string, KEY_NAME: string }[]
local KEYS_LIST = {
  { KEY = "a", KEY_NAME =  "A" },
  { KEY = "b", KEY_NAME =  "B" },
  { KEY = "c", KEY_NAME =  "C" },
  { KEY = "d", KEY_NAME =  "D" },
  { KEY = "e", KEY_NAME =  "E" },
  { KEY = "f", KEY_NAME =  "F" },
  { KEY = "g", KEY_NAME =  "G" },
  { KEY = "h", KEY_NAME =  "H" },
  { KEY = "i", KEY_NAME =  "I" },
  { KEY = "j", KEY_NAME =  "J" },
  { KEY = "k", KEY_NAME =  "K" },
  { KEY = "l", KEY_NAME =  "L" },
  { KEY = "m", KEY_NAME =  "M" },
  { KEY = "n", KEY_NAME =  "N" },
  { KEY = "o", KEY_NAME =  "O" },
  { KEY = "p", KEY_NAME =  "P" },
  { KEY = "q", KEY_NAME =  "Q" },
  { KEY = "r", KEY_NAME =  "R" },
  { KEY = "s", KEY_NAME =  "S" },
  { KEY = "t", KEY_NAME =  "T" },
  { KEY = "u", KEY_NAME =  "U" },
  { KEY = "v", KEY_NAME =  "V" },
  { KEY = "w", KEY_NAME =  "W" },
  { KEY = "x", KEY_NAME =  "X" },
  { KEY = "y", KEY_NAME =  "Y" },
  { KEY = "z", KEY_NAME =  "Z" },
  { KEY = "`", KEY_NAME =  "_backquote" },
  { KEY = "-", KEY_NAME =  "_hyphen" },
  { KEY = ".", KEY_NAME =  "_period" },
  { KEY = "+", KEY_NAME =  "_plus" },
  { KEY = "/", KEY_NAME =  "_slash" },
}

---@diagnostic disable-next-line: lowercase-global
function getClientInfo()
  return {
    name = "DLIn: init",
    category = "Direct Lyric Input",
    author = "fanta",
    versionNumber = 1,
    minEditorVersion = 65540
  }
end

---ファイルを読み込む
---@param path string ファイルのパス
---@return string[] | nil # ファイルが存在しない場合はnil
local function readFile(path)
  local file = io.open(path, "r")
  if file == nil then
    return nil
  end

  local tmp = {}
  for line in file:lines() do
    table.insert(tmp, line)
  end
  file:close()

  return tmp
end

---テンプレートを元にスクリプトファイルを生成
---@param path string 生成するスクリプトファイルのパス
---@param template string[] テンプレートファイルの内容
---@param vars table テンプレートファイル内の変数を置換する文字列のテーブル
local function writeTemplate(path, template, vars)
  local file = io.open(path, "w") --[[@as file*]]
  for _, line in ipairs(template) do
    line = line:gsub("__([%w_]+)__", function (key)
      return vars[key]
    end)
    file:write(line .. "\n")
  end
  file:close()
end

---@diagnostic disable-next-line: lowercase-global
function main()
  local ostype = SV:getHostInfo().osType
  local scriptDirPath = SV:showInputBox("ファイルパス入力", "スクリプトファイルのファイルパスを入力して下さい", PATH_SETS[ostype].default)
  local packagePath = table.concat(
    { scriptDirPath, DIR_NAME, MODULES_DIR_NAME, "?.lua" },
    PATH_SETS[ostype].sep
  )

  local keysTemplatePath = table.concat(
    { scriptDirPath, DIR_NAME, TEMPLATES_DIR_NAME, INPUT_TEMPLATE .. TEMPLATE_FILE_EXT },
    PATH_SETS[ostype].sep
  )
  local keysTemplate = readFile(keysTemplatePath)
  if keysTemplate then
    for _, key in ipairs(KEYS_LIST) do
      local keyName = "input-" .. key.KEY_NAME
      local keyPath = table.concat(
        { scriptDirPath, DIR_NAME, OUTPUT_DIR_NAME, keyName .. ".lua" },
        PATH_SETS[ostype].sep
      )

      writeTemplate(keyPath, keysTemplate, {
        KEY = key.KEY,
        KEY_NAME = key.KEY_NAME,
        PACKAGE_PATH = packagePath
      })
    end
  end

  for _, templateName in ipairs(OTHER_TEMPLATES) do
    local templatePath = table.concat(
      { scriptDirPath, DIR_NAME, TEMPLATES_DIR_NAME, templateName .. TEMPLATE_FILE_EXT },
      PATH_SETS[ostype].sep
    )
    local template = readFile(templatePath)
    if template then
      local outputPath = table.concat(
        { scriptDirPath, DIR_NAME, OUTPUT_DIR_NAME, templateName .. ".lua" },
        PATH_SETS[ostype].sep
      )
      writeTemplate(outputPath, template, {
        PACKAGE_PATH = packagePath
      })
    end
  end

  return SV:finish()
end
