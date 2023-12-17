local USE_HIRAGANA = true

local VIEW_TOLERANCE = 0.1

local LYRIC_END = "\x80-\xBF+-"
local NEXT_NOTE_CHAR = "/"
local SLIDE_KEYS = { "l", "x", "`" }

local SCRIPT_DIR_PATH = "/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/direct-lyric-input"
local OUTPUT_DIR_NAME = "output"
local TEMPLATES_DIR_NAME = "templates"
local TEMPLATE_FILE_EXT = ".txt"
local INPUT_TEMPLATE = "input"
local OTHER_TEMPLATES = { "lyricClear", "lyricClearAll" }
local PATH_SEPS = { Windows = "\\", macOS = "/", Linux = "/", Unknown = "/" }

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

---@type table<string, string[]>
local KANA_RULES = {
  a = { "あ" }, i = { "い" }, u = { "う" }, e = { "え" }, o = { "お" },

  ka = { "か" }, ki = { "き" }, ku = { "く" }, ke = { "け" }, ko = { "こ" },
  sa = { "さ" }, si = { "し" }, su = { "す" }, se = { "せ" }, so = { "そ" },
  ta = { "た" }, ti = { "ち" }, tu = { "つ" }, te = { "て" }, to = { "と" },
  na = { "な" }, ni = { "に" }, nu = { "ぬ" }, ne = { "ね" }, no = { "の" },
  ha = { "は" }, hi = { "ひ" }, hu = { "ふ" }, he = { "へ" }, ho = { "ほ" },
  ma = { "ま" }, mi = { "み" }, mu = { "む" }, me = { "め" }, mo = { "も" },
  ya = { "や" }, yi = { "うぃ" }, yu = { "ゆ" }, ye = { "いぇ" }, yo = { "よ" },
  ra = { "ら" }, ri = { "り" }, ru = { "る" }, re = { "れ" }, ro = { "ろ" },
  wa = { "わ" }, wi = { "うぃ" }, wu = { "う" }, we = { "うぇ" }, wo = { "を" },
  nn = { "ん" }, xn = { "ん" },
  ga = { "が" }, gi = { "ぎ" }, gu = { "ぐ" }, ge = { "げ" }, go = { "ご" },
  za = { "ざ" }, zi = { "じ" }, zu = { "ず" }, ze = { "ぜ" }, zo = { "ぞ" },
  da = { "だ" }, di = { "ぢ" }, du = { "づ" }, de = { "で" }, ["do"] = { "ど" },
  ba = { "ば" }, bi = { "び" }, bu = { "ぶ" }, be = { "べ" }, bo = { "ぼ" },
  pa = { "ぱ" }, pi = { "ぴ" }, pu = { "ぷ" }, pe = { "ぺ" }, po = { "ぽ" },
  fa = { "ふぁ" }, fi = { "ふぃ" }, fu = { "ふ" }, fe = { "ふぇ" }, fo = { "ふぉ" },
  ja = { "じゃ" }, ji = { "じ" }, ju = { "じゅ" }, je = { "じぇ" }, jo = { "じょ" },
  va = { "ゔぁ" }, vi = { "ゔぃ" }, vu = { "ゔ" }, ve = { "ゔぇ" }, vo = { "ゔぉ" },
  xa = { "ぁ" }, xi = { "ぃ" }, xu = { "ぅ" }, xe = { "ぇ" }, xo = { "ぉ" },
  la = { "ぁ" }, li = { "ぃ" }, lu = { "ぅ" }, le = { "ぇ" }, lo = { "ぉ" },

  kk = { "っ", "k" }, ss = { "っ", "s" }, tt = { "っ", "t" }, hh = { "っ", "h" }, mm = { "っ", "m" },
  yy = { "っ", "y" }, rr = { "っ", "r" }, ww = { "っ", "w" }, gg = { "っ", "g" }, zz = { "っ", "z" },
  dd = { "っ", "d" }, bb = { "っ", "b" }, pp = { "っ", "p" }, ff = { "っ", "f" }, jj = { "っ", "j" },
  vv = { "っ", "v" }, xx = { "っ", "x" }, ll = { "っ", "l" }, cc = { "っ", "c" },

  nk = { "ん", "k" }, ns = { "ん", "s" }, nt = { "ん", "t" }, nh = { "ん", "h" }, nm = { "ん", "m" },
  nr = { "ん", "r" }, nw = { "ん", "w" }, ng = { "ん", "g" }, nz = { "ん", "z" }, nd = { "ん", "d" },
  nb = { "ん", "b" }, np = { "ん", "p" }, nf = { "ん", "f" }, nj = { "ん", "j" }, nv = { "ん", "v" },
  nx = { "ん", "x" }, nl = { "ん", "l" }, nc = { "ん", "c" },

  kya = { "きゃ" }, kyi = { "きぃ" }, kyu = { "きゅ" }, kye = { "きぇ" }, kyo = { "きょ" },
  sya = { "しゃ" }, syi = { "しぃ" }, syu = { "しゅ" }, sye = { "しぇ" }, syo = { "しょ" },
  tya = { "ちゃ" }, tyi = { "ちぃ" }, tyu = { "ちゅ" }, tye = { "ちぇ" }, tyo = { "ちょ" },
  cya = { "ちゃ" }, cyi = { "ちぃ" }, cyu = { "ちゅ" }, cye = { "ちぇ" }, cyo = { "ちょ" },
  nya = { "にゃ" }, nyi = { "にぃ" }, nyu = { "にゅ" }, nye = { "にぇ" }, nyo = { "にょ" },
  hya = { "ひゃ" }, hyi = { "ひぃ" }, hyu = { "ひゅ" }, hye = { "ひぇ" }, hyo = { "ひょ" },
  mya = { "みゃ" }, myi = { "みぃ" }, myu = { "みゅ" }, mye = { "みぇ" }, myo = { "みょ" },
  rya = { "りゃ" }, ryi = { "りぃ" }, ryu = { "りゅ" }, rye = { "りぇ" }, ryo = { "りょ" },
  gya = { "ぎゃ" }, gyi = { "ぎぃ" }, gyu = { "ぎゅ" }, gye = { "ぎぇ" }, gyo = { "ぎょ" },
  zya = { "じゃ" }, zyi = { "じぃ" }, zyu = { "じゅ" }, zye = { "じぇ" }, zyo = { "じょ" },
  jya = { "じゃ" }, jyi = { "じぃ" }, jyu = { "じゅ" }, jye = { "じぇ" }, jyo = { "じょ" },
  dya = { "ぢゃ" }, dyi = { "ぢぃ" }, dyu = { "ぢゅ" }, dye = { "ぢぇ" }, dyo = { "ぢょ" },
  bya = { "びゃ" }, byi = { "びぃ" }, byu = { "びゅ" }, bye = { "びぇ" }, byo = { "びょ" },
  pya = { "ぴゃ" }, pyi = { "ぴぃ" }, pyu = { "ぴゅ" }, pye = { "ぴぇ" }, pyo = { "ぴょ" },
  vya = { "ゔゃ" }, vyu = { "ゔゅ" }, vyo = { "ゔょ" },
  xya = { "ゃ" }, xyu = { "ゅ" }, xyo = { "ょ" },
  lya = { "ゃ" }, lyu = { "ゅ" }, lyo = { "ょ" },
  xtu = { "っ" }, ltu = { "っ" },
  kwa = { "くぁ" }, kwi = { "くぃ" }, kwu = { "くぅ" }, kwe = { "くぇ" }, kwo = { "くぉ" },
  swa = { "すぁ" }, swi = { "すぃ" }, swu = { "すぅ" }, swe = { "すぇ" }, swo = { "すぉ" },
  twa = { "とぁ" }, twi = { "とぃ" }, twu = { "とぅ" }, twe = { "とぇ" }, two = { "とぉ" },
  hwa = { "ふぁ" }, hwi = { "ふぃ" }, hwu = { "ふぅ" }, hwe = { "ふぇ" }, hwo = { "ふぉ" },
  fwa = { "ふぁ" }, fwi = { "ふぃ" }, fwu = { "ふぅ" }, fwe = { "ふぇ" }, fwo = { "ふぉ" },
  gwa = { "ぐぁ" }, gwi = { "ぐぃ" }, gwu = { "ぐぅ" }, gwe = { "ぐぇ" }, gwo = { "ぐぉ" },
  dwa = { "どぁ" }, dwi = { "どぃ" }, dwu = { "どぅ" }, dwe = { "どぇ" }, dwo = { "どぉ" },
  xwa = { "ゎ" },
  lwa = { "ゎ" },
  sha = { "しゃ" }, shi = { "し" }, shu = { "しゅ" }, she = { "しぇ" }, sho = { "しょ" },
  cha = { "ちゃ" }, chi = { "ち" }, chu = { "ちゅ" }, che = { "ちぇ" }, cho = { "ちょ" },
  tha = { "てゃ" }, thi = { "てぃ" }, thu = { "てゅ" }, the = { "てぇ" }, tho = { "てょ" },
  dha = { "でゃ" }, dhi = { "でぃ" }, dhu = { "でゅ" }, dhe = { "でぇ" }, dho = { "でょ" },
  tsa = { "つぁ" }, tsi = { "つぃ" }, tsu = { "つ" }, tse = { "つぇ" }, tso = { "つぉ" },

  xtsu = { "っ" },
}

----------------------------------------------
--- 以下init処理
----------------------------------------------

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
  local packagePath = table.concat(
    { SCRIPT_DIR_PATH, "?.lua" },
    PATH_SEPS[ostype]
  )

  local keysTemplatePath = table.concat(
    { SCRIPT_DIR_PATH, TEMPLATES_DIR_NAME, INPUT_TEMPLATE .. TEMPLATE_FILE_EXT },
    PATH_SEPS[ostype]
  )
  local keysTemplate = readFile(keysTemplatePath)
  if keysTemplate then
    for _, key in ipairs(KEYS_LIST) do
      local keyName = "input-" .. key.KEY_NAME
      local keyPath = table.concat(
        { SCRIPT_DIR_PATH, OUTPUT_DIR_NAME, keyName .. ".lua" },
        PATH_SEPS[ostype]
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
      { SCRIPT_DIR_PATH, TEMPLATES_DIR_NAME, templateName .. TEMPLATE_FILE_EXT },
      PATH_SEPS[ostype]
    )
    local template = readFile(templatePath)
    if template then
      local outputPath = table.concat(
        { SCRIPT_DIR_PATH, OUTPUT_DIR_NAME, templateName .. ".lua" },
        PATH_SEPS[ostype]
      )
      writeTemplate(outputPath, template, {
        PACKAGE_PATH = packagePath
      })
    end
  end

  return SV:finish()
end

----------------------------------------------
--- 以下モジュール用処理
----------------------------------------------

local check = {}
for k in pairs(KANA_RULES) do
    check[#k] = true
end

local KEY_LENGHT = {}
for k in pairs(check) do
  table.insert(KEY_LENGHT, k)
end
table.sort(KEY_LENGHT, function (a, b)
  return a > b
end)

local LYRIC_END_PATTERN = "[" .. NEXT_NOTE_CHAR .. LYRIC_END .. "]$"
local SLIDE_KEYS_SET = {}
for _, key in ipairs(SLIDE_KEYS) do
  SLIDE_KEYS_SET[key] = true
end

---ローマ字列の最後をひらがなに変換
---@param romaji string
---@return string, string | nil
local function convertRomaji(romaji)
  for _, i in ipairs(KEY_LENGHT) do
    if i <= #romaji then
      local to = KANA_RULES[romaji:sub(-i)]

      if to then
        return romaji:sub(1, ~i) .. to[1], to[2]
      end
    end
  end
  return romaji
end

---歌詞のスクリプト用文字を変換・削除
---@param note Note
---@param lyric string?
---@return string
local function noteLyricNormalize(note, lyric)
  lyric = lyric or note:getLyrics()
  local lastChar = lyric:sub(-1)

  if lastChar == "." and #lyric > 1 then
    local fixedLyric = lyric:sub(1, -2) .. " "
    note:setLyrics(fixedLyric)
    return fixedLyric
  elseif lastChar == NEXT_NOTE_CHAR then
    local fixedLyric = lyric:sub(1, -2)
    note:setLyrics(fixedLyric)
    return fixedLyric
  end

  return lyric
end

---ノート配列を親グループのインデックス順にソート（破壊的）
---@param notes Note[]
---@return Note[]
local function sortNotesByIndex(notes)
  local indexs = {}
  for _, note in ipairs(notes) do
    indexs[note] = note:getIndexInParent()
  end

  table.sort(notes, function (a, b)
    return indexs[a] < indexs[b]
  end)

  return notes
end

---ノートが画面外にある時、収まるように画面を移動する
---@param mainEditor MainEditorView
---@param note Note
local function focusNote(mainEditor, note)
  local coordinate = mainEditor:getNavigation()
  local viewRangeHorizontal = coordinate:getTimeViewRange()
  local viewLeft, viewRight = viewRangeHorizontal[1], viewRangeHorizontal[2]
  local noteLeft, noteRight = note:getOnset(), note:getEnd()

  local toleranceBlicks = (viewRight - viewLeft) * VIEW_TOLERANCE

  if noteRight < viewLeft + toleranceBlicks or viewRight - toleranceBlicks < noteLeft then
    coordinate:setTimeLeft(noteLeft - toleranceBlicks)
  end

  local viewRangeVertical = coordinate:getValueViewRange()
  local viewBottom, viewTop = viewRangeVertical[1], viewRangeVertical[2]
  local notePitch = note:getPitch()

  if notePitch < viewBottom or viewTop < notePitch then
    coordinate:setValueCenter(notePitch)
  end
end

---@generic T
---@param arr T[]
---@param callback fun(v: T, i: number, self: T[]): boolean
---@return T | nil, number
local function arrayFind(arr, callback)
  for i, v in ipairs(arr) do
    if callback(v, i, arr) then
      return v, i
    end
  end

  return nil, -1
end

---歌詞が完全に入力されていない最初のノートを取得
---@param noteGroup Note[]
---@param key string
---@return Note | nil, number, string
local function getTargetNote(noteGroup, key)
  if #noteGroup == 0 then
    return nil, -1, ""
  end

  local noSlide = SLIDE_KEYS_SET[key] == nil
  local targetNote, targetNoteIndex = arrayFind(noteGroup, function (note)
    return note:getLyrics() == ""
  end)

  if targetNote == nil then
    return noteGroup[#noteGroup], #noteGroup, noteLyricNormalize(noteGroup[#noteGroup])
  end

  if targetNoteIndex <= 1 then
    return targetNote, targetNoteIndex, ""
  end

  local prevIndex = targetNoteIndex - 1
  local prevNote = noteGroup[prevIndex]
  local prevLyric = prevNote:getLyrics()
  local prevLyricNormalized = noteLyricNormalize(prevNote, prevLyric)

  if noSlide and prevLyric:find(LYRIC_END_PATTERN) then
    return targetNote, targetNoteIndex, ""
  end

  return prevNote, prevIndex, prevLyricNormalized
end

return {
  getTargetNote = getTargetNote,
  sortNotesByIndex = sortNotesByIndex,
  convertRomaji = convertRomaji,
  focusNote = focusNote,
  USE_HIRAGANA = USE_HIRAGANA,
}
