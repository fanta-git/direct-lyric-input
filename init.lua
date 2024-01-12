----------------------------------------------
--- ここから設定用
----------------------------------------------

-- 設定の反映にはファイルの保存後スクリプトの再読み込み、initの実行、再度スクリプトの再読み込みが必要です

-- ひらがな変換を行うなら true , 行わない（常にアルファベットのまま）なら false を設定
-- 設定が true でも、ノートの言語設定が日本語でない時と歌詞が . から始まるときはひらがな変換は行われない
-- グループ/トラックの設定が英語でもノートごとの設定がデフォルトのままならひらがな変換はこの設定に従う
local USE_HIRAGANA = true

-- 画面の移動時、画面端からどれだけ余裕を持たせるか（0.1なら画面幅の10%以上を開ける）
-- デフォルト設定は 0.1
local VIEW_TOLERANCE = 0.1

-- 歌詞入力対象のノートを次に飛ばす条件の文字
-- ひらがななどマルチバイト文字に加えてこれらの文字で終わるノートにはそれ以上文字を追加せず、入力対象を次へ移動させる
local LYRIC_END_CHARS = { "+", "-", "`" }

-- 非ひらがな入力時、入力対象を次のノートに飛ばすための文字
-- デフォルト設定は "/" 、英語ノートでも[hello/]と末尾に / を入れると次のノートに移動できる 移動すると末尾の / は消える
local NEXT_NOTE_CHAR = "/"

-- 文頭に来るときは前のノートに移動する文字
-- 例えば[tuxa]と入力した時、ぁが前のノートに滑り込むため一つのノートに「つぁ」と入力される
local SLIDE_CHARS = { "ゃ", "ゅ", "ょ", "ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "`" }

-- このスクリプトのあるフォルダへのフルパス、設定しなくてもスクリプトは使えるが、initの実行時には必要
-- バックスラッシュにはエスケープが要るため、Windowsの場合 C:\\User\\〜 のようになる
-- Macならデフォルトのままで良い 末尾のスラッシュは不要
local SCRIPT_DIR_PATH = "/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/direct-lyric-input"

-- ファイル名まわり 触らないで良い
local OUTPUT_DIR_NAME = "output"
local TEMPLATES_DIR_NAME = "templates"
local TEMPLATE_FILE_EXT = ".txt"
local INPUT_TEMPLATE = "input"
local OTHER_TEMPLATES = { "lyricClear", "lyricClearAll" }
local PATH_SEPS = { Windows = "\\", macOS = "/", Linux = "/", Unknown = "/" }

-- 以下はスクリプト生成用のテンプレート
-- 例えば9にも対応させるときは { KEY = "9", KEY_NAME = "9" }, を追加してinitを実行し、ショートカットを割り当てる
-- KEYは入力される文字、KEY_NAMEはスクリプトファイル名
---@type { KEY: string, KEY_NAME: string }[]
local KEYS_LIST = {
  { KEY = "a", KEY_NAME = "A" },
  { KEY = "b", KEY_NAME = "B" },
  { KEY = "c", KEY_NAME = "C" },
  { KEY = "d", KEY_NAME = "D" },
  { KEY = "e", KEY_NAME = "E" },
  { KEY = "f", KEY_NAME = "F" },
  { KEY = "g", KEY_NAME = "G" },
  { KEY = "h", KEY_NAME = "H" },
  { KEY = "i", KEY_NAME = "I" },
  { KEY = "j", KEY_NAME = "J" },
  { KEY = "k", KEY_NAME = "K" },
  { KEY = "l", KEY_NAME = "L" },
  { KEY = "m", KEY_NAME = "M" },
  { KEY = "n", KEY_NAME = "N" },
  { KEY = "o", KEY_NAME = "O" },
  { KEY = "p", KEY_NAME = "P" },
  { KEY = "q", KEY_NAME = "Q" },
  { KEY = "r", KEY_NAME = "R" },
  { KEY = "s", KEY_NAME = "S" },
  { KEY = "t", KEY_NAME = "T" },
  { KEY = "u", KEY_NAME = "U" },
  { KEY = "v", KEY_NAME = "V" },
  { KEY = "w", KEY_NAME = "W" },
  { KEY = "x", KEY_NAME = "X" },
  { KEY = "y", KEY_NAME = "Y" },
  { KEY = "z", KEY_NAME = "Z" },
  { KEY = "`", KEY_NAME = "_backquote" },
  { KEY = "'", KEY_NAME = "_singlequote" },
  { KEY = "-", KEY_NAME = "_hyphen" },
  { KEY = ".", KEY_NAME = "_period" },
  { KEY = "+", KEY_NAME = "_plus" },
  { KEY = "/", KEY_NAME = "_slash" },
}

-- ひらがな変換用のルール 変換時はルールが長いものを優先する（a より kaを優先）
-- 例えば「cl」→「っ」を追加したければ cl = { "っ" }, を追加する
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
--- 設定用ここまで
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

---プリミティブ値を文字列に変換
---@param from any
---@return string
local function primitiveToString(from)
  if type(from) == "string" then
    return '"' .. from .. '"'
  end
  return tostring(from)
end

---配列を文字列に変換
---@generic T
---@param from T[]
---@param convertFunc? fun(val: T): any
---@return string
local function arrayToString(from, convertFunc)
  local arr = {}
  for _, v in ipairs(from) do
    local str = (convertFunc or primitiveToString)(v)
    table.insert(arr, str)
  end
  return "{" .. table.concat(arr, ",") .. "}"
end

---連想配列を文字列に変換
---@generic T
---@param from table<any, T>
---@param convertFunc? fun(val: T): string
---@return string
local function tableToString(from, convertFunc)
  local arr = {}
  for k, v in pairs(from) do
    local str = (convertFunc or primitiveToString)(v)
    table.insert(arr, ('["%s"]=%s'):format(k, str))
  end
  return "{" .. table.concat(arr, ",") .. "}"
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
---@param vars table<string, string> テンプレートファイル内の変数を置換する文字列のテーブル
---@return boolean # 生成に成功した場合はtrue、失敗した場合はfalse
local function writeTemplate(path, template, vars)
  local file = io.open(path, "w")
  if file == nil then
    return false
  end
  for _, line in ipairs(template) do
    line = line:gsub("__([%w_]+)__", function (key)
      return vars[key]
    end)
    file:write(line .. "\n")
  end
  file:close()
  return true
end

---@diagnostic disable-next-line: lowercase-global
function main()
  local kanaRulesMap = {}
  local checkMap = {}
  for k, v in pairs(KANA_RULES) do
    local lastChar = k:sub(-1)
    kanaRulesMap[lastChar] = kanaRulesMap[lastChar] or {}
    kanaRulesMap[lastChar][k] = v

    checkMap[lastChar] = checkMap[lastChar] or {}
    checkMap[lastChar][#k] = true
  end

  local kanaKeyLengthMap = {}
  for k, v in pairs(checkMap) do
    local keylength = {}
    kanaKeyLengthMap[k] = keylength

    for l in pairs(v) do
      table.insert(keylength, l)
    end

    table.sort(keylength, function (a, b)
      return a > b
    end)
  end

  local ostype = SV:getHostInfo().osType
  local keysTemplatePath = table.concat(
    { SCRIPT_DIR_PATH, TEMPLATES_DIR_NAME, INPUT_TEMPLATE .. TEMPLATE_FILE_EXT },
    PATH_SEPS[ostype]
  )
  local keysTemplate = readFile(keysTemplatePath)
  if keysTemplate == nil then
    SV:showMessageBox("エラー", "テンプレートの読み込みに失敗しました。このスクリプトのフォルダへのパスが間違っているかもしれません。以下のパスにスクリプトフォルダは存在していますか？パスの変更はinit.luaをテキストエディタなどで編集することで行えます。\n\n" .. SCRIPT_DIR_PATH)
    return SV:finish()
  end
  for _, key in ipairs(KEYS_LIST) do
    local keyName = "input-" .. key.KEY_NAME
    local keyPath = table.concat(
      { SCRIPT_DIR_PATH, OUTPUT_DIR_NAME, keyName .. ".lua" },
      PATH_SEPS[ostype]
    )

    local isWrited = writeTemplate(keyPath, keysTemplate, {
      KEY = primitiveToString(key.KEY),
      KEY_NAME = primitiveToString(key.KEY_NAME),
      KEY_LENGHT = arrayToString(kanaKeyLengthMap[key.KEY] or {}),
      KANA_RULES = tableToString(kanaRulesMap[key.KEY] or {}, arrayToString),
      SLIDE_CHARS = arrayToString(SLIDE_CHARS),
      LYRIC_END_CHARS = arrayToString(LYRIC_END_CHARS),
      NEXT_NOTE_CHAR = primitiveToString(NEXT_NOTE_CHAR),
      VIEW_TOLERANCE = primitiveToString(VIEW_TOLERANCE),
      USE_HIRAGANA = primitiveToString(USE_HIRAGANA),
    })

    if not isWrited then
      SV:showMessageBox("エラー", "スクリプトの生成に失敗しました。" .. OUTPUT_DIR_NAME .. "フォルダがスクリプトフォルダに存在していないかもしれません。")
      return SV:finish()
    end
  end

  for _, templateName in ipairs(OTHER_TEMPLATES) do
    local templatePath = table.concat(
      { SCRIPT_DIR_PATH, TEMPLATES_DIR_NAME, templateName .. TEMPLATE_FILE_EXT },
      PATH_SEPS[ostype]
    )

    local template = readFile(templatePath)
    if template == nil then
      SV:showMessageBox("エラー", templateName .. "テンプレートの読み込みに失敗しました。スクリプトフォルダのtemplateフォルダ内にこのテンプレートは存在していますか？")
      return SV:finish()
    end

    local outputPath = table.concat(
      { SCRIPT_DIR_PATH, OUTPUT_DIR_NAME, templateName .. ".lua" },
      PATH_SEPS[ostype]
    )
    writeTemplate(outputPath, template, {
      VIEW_TOLERANCE = primitiveToString(VIEW_TOLERANCE),
    })
  end

  SV:showMessageBox("実行完了", "スクリプトの生成が完了しました。スクリプトを再読み込みしてください。\n新たにキー設定を増やした場合はキーボードショートカットの設定も必要です。")

  return SV:finish()
end
