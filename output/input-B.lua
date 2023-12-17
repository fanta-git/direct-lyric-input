local KEY = "b"
local KEY_LENGHT = {4,3,2,1}
local KANA_RULES = {["dha"]={"でゃ"},["cha"]={"ちゃ"},["ng"]={"ん","g"},["vv"]={"っ","v"},["gg"]={"っ","g"},["nv"]={"ん","v"},["za"]={"ざ"},["ya"]={"や"},["xa"]={"ぁ"},["wa"]={"わ"},["nf"]={"ん","f"},["cyi"]={"ちぃ"},["ww"]={"っ","w"},["gyi"]={"ぎぃ"},["dyi"]={"ぢぃ"},["ff"]={"っ","f"},["kyi"]={"きぃ"},["hyi"]={"ひぃ"},["nyi"]={"にぃ"},["nw"]={"ん","w"},["myi"]={"みぃ"},["de"]={"で"},["be"]={"べ"},["pe"]={"ぺ"},["ne"]={"ね"},["te"]={"て"},["se"]={"せ"},["re"]={"れ"},["he"]={"へ"},["ge"]={"げ"},["fe"]={"ふぇ"},["me"]={"め"},["le"]={"ぇ"},["ke"]={"け"},["je"]={"じぇ"},["dd"]={"っ","d"},["nd"]={"ん","d"},["tha"]={"てゃ"},["sha"]={"しゃ"},["swi"]={"すぃ"},["twi"]={"とぃ"},["a"]={"あ"},["chi"]={"ち"},["e"]={"え"},["cc"]={"っ","c"},["i"]={"い"},["zz"]={"っ","z"},["nc"]={"ん","c"},["nz"]={"ん","z"},["bb"]={"っ","b"},["jya"]={"じゃ"},["o"]={"お"},["nb"]={"ん","b"},["gya"]={"ぎゃ"},["hya"]={"ひゃ"},["u"]={"う"},["bya"]={"びゃ"},["cya"]={"ちゃ"},["dya"]={"ぢゃ"},["ryi"]={"りぃ"},["du"]={"づ"},["pyi"]={"ぴぃ"},["bu"]={"ぶ"},["hu"]={"ふ"},["gu"]={"ぐ"},["fu"]={"ふ"},["fa"]={"ふぁ"},["da"]={"だ"},["ba"]={"ば"},["na"]={"な"},["ma"]={"ま"},["la"]={"ぁ"},["ka"]={"か"},["ja"]={"じゃ"},["ha"]={"は"},["ga"]={"が"},["va"]={"ゔぁ"},["ta"]={"た"},["sa"]={"さ"},["ra"]={"ら"},["pa"]={"ぱ"},["twu"]={"とぅ"},["swu"]={"すぅ"},["kwu"]={"くぅ"},["zu"]={"ず"},["hwu"]={"ふぅ"},["gwu"]={"ぐぅ"},["fwu"]={"ふぅ"},["tu"]={"つ"},["su"]={"す"},["ru"]={"る"},["yu"]={"ゆ"},["xu"]={"ぅ"},["wu"]={"う"},["vu"]={"ゔ"},["mu"]={"む"},["lu"]={"ぅ"},["ku"]={"く"},["ju"]={"じゅ"},["gwi"]={"ぐぃ"},["pu"]={"ぷ"},["nu"]={"ぬ"},["pye"]={"ぴぇ"},["sye"]={"しぇ"},["rye"]={"りぇ"},["tye"]={"ちぇ"},["bo"]={"ぼ"},["swa"]={"すぁ"},["do"]={"ど"},["go"]={"ご"},["fo"]={"ふぉ"},["ho"]={"ほ"},["ko"]={"こ"},["jo"]={"じょ"},["dwu"]={"どぅ"},["nn"]={"ん"},["xn"]={"ん"},["ryu"]={"りゅ"},["tyu"]={"ちゅ"},["syu"]={"しゅ"},["nyu"]={"にゅ"},["myu"]={"みゅ"},["pyu"]={"ぴゅ"},["jyu"]={"じゅ"},["zi"]={"じ"},["yi"]={"うぃ"},["xi"]={"ぃ"},["wi"]={"うぃ"},["vi"]={"ゔぃ"},["gyu"]={"ぎゅ"},["mo"]={"も"},["lo"]={"ぉ"},["no"]={"の"},["gwe"]={"ぐぇ"},["po"]={"ぽ"},["so"]={"そ"},["ro"]={"ろ"},["zyu"]={"じゅ"},["to"]={"と"},["wo"]={"を"},["vo"]={"ゔぉ"},["yo"]={"よ"},["xo"]={"ぉ"},["xyu"]={"ゅ"},["zo"]={"ぞ"},["dhe"]={"でぇ"},["zya"]={"じゃ"},["vya"]={"ゔゃ"},["xya"]={"ゃ"},["tse"]={"つぇ"},["rya"]={"りゃ"},["sya"]={"しゃ"},["tya"]={"ちゃ"},["mya"]={"みゃ"},["nya"]={"にゃ"},["shu"]={"しゅ"},["pya"]={"ぴゃ"},["byu"]={"びゅ"},["xx"]={"っ","x"},["dyu"]={"ぢゅ"},["cyu"]={"ちゅ"},["nx"]={"ん","x"},["chu"]={"ちゅ"},["che"]={"ちぇ"},["tsu"]={"つ"},["yy"]={"っ","y"},["kwa"]={"くぁ"},["lwa"]={"ゎ"},["cye"]={"ちぇ"},["bye"]={"びぇ"},["gwa"]={"ぐぁ"},["dye"]={"ぢぇ"},["gye"]={"ぎぇ"},["fwa"]={"ふぁ"},["hye"]={"ひぇ"},["kye"]={"きぇ"},["jye"]={"じぇ"},["mye"]={"みぇ"},["nye"]={"にぇ"},["cho"]={"ちょ"},["dho"]={"でょ"},["tsa"]={"つぁ"},["rr"]={"っ","r"},["nk"]={"ん","k"},["nr"]={"ん","r"},["kk"]={"っ","k"},["dhi"]={"でぃ"},["tso"]={"つぉ"},["tsi"]={"つぃ"},["dhu"]={"でゅ"},["xtsu"]={"っ"},["tho"]={"てょ"},["the"]={"てぇ"},["thu"]={"てゅ"},["thi"]={"てぃ"},["ye"]={"いぇ"},["xe"]={"ぇ"},["we"]={"うぇ"},["ve"]={"ゔぇ"},["gwo"]={"ぐぉ"},["fwo"]={"ふぉ"},["sho"]={"しょ"},["ze"]={"ぜ"},["kwo"]={"くぉ"},["she"]={"しぇ"},["shi"]={"し"},["hwo"]={"ふぉ"},["xwa"]={"ゎ"},["nj"]={"ん","j"},["ns"]={"ん","s"},["dwo"]={"どぉ"},["swo"]={"すぉ"},["jj"]={"っ","j"},["dwe"]={"どぇ"},["dwi"]={"どぃ"},["dwa"]={"どぁ"},["ss"]={"っ","s"},["fwe"]={"ふぇ"},["two"]={"とぉ"},["di"]={"ぢ"},["fwi"]={"ふぃ"},["bi"]={"び"},["hwe"]={"ふぇ"},["xyo"]={"ょ"},["hwi"]={"ふぃ"},["zyo"]={"じょ"},["hwa"]={"ふぁ"},["twe"]={"とぇ"},["twa"]={"とぁ"},["swe"]={"すぇ"},["kwe"]={"くぇ"},["kwi"]={"くぃ"},["xtu"]={"っ"},["ltu"]={"っ"},["tyi"]={"ちぃ"},["ti"]={"ち"},["si"]={"し"},["ri"]={"り"},["lyu"]={"ゅ"},["pi"]={"ぴ"},["lya"]={"ゃ"},["ni"]={"に"},["mi"]={"み"},["li"]={"ぃ"},["ki"]={"き"},["ji"]={"じ"},["np"]={"ん","p"},["hi"]={"ひ"},["gi"]={"ぎ"},["fi"]={"ふぃ"},["vyu"]={"ゔゅ"},["ll"]={"っ","l"},["nyo"]={"にょ"},["byi"]={"びぃ"},["kyo"]={"きょ"},["kyu"]={"きゅ"},["jyi"]={"じぃ"},["zye"]={"じぇ"},["zyi"]={"じぃ"},["dyo"]={"ぢょ"},["cyo"]={"ちょ"},["pp"]={"っ","p"},["nl"]={"ん","l"},["syi"]={"しぃ"},["hyu"]={"ひゅ"},["byo"]={"びょ"},["kya"]={"きゃ"},["lyo"]={"ょ"},["nm"]={"ん","m"},["mm"]={"っ","m"},["myo"]={"みょ"},["hyo"]={"ひょ"},["gyo"]={"ぎょ"},["jyo"]={"じょ"},["nh"]={"ん","h"},["tyo"]={"ちょ"},["syo"]={"しょ"},["vyo"]={"ゔょ"},["nt"]={"ん","t"},["pyo"]={"ぴょ"},["hh"]={"っ","h"},["ryo"]={"りょ"},["tt"]={"っ","t"}}
local SLIDE_KEYS_SET = {["x"]=true,["`"]=true,["l"]=true}
local LYRIC_END_PATTERN = "[/�-�+-]$"
local NEXT_NOTE_CHAR = "/"
local VIEW_TOLERANCE = 0.1
local USE_HIRAGANA = true

---@diagnostic disable-next-line: lowercase-global
function getClientInfo()
  return {
    name = "DLIn: key-" .. "B",
    category = "Direct Lyric Input",
    author = "fanta",
    versionNumber = 1,
    minEditorVersion = 65540
  }
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

---@diagnostic disable-next-line: lowercase-global
function main()
  local mainEditor = SV:getMainEditor()
  local selection = mainEditor:getSelection()
  local selectedNotes = sortNotesByIndex(selection:getSelectedNotes())
  local firstNote, noteIndex, lyric = getTargetNote(selectedNotes, KEY)
  if firstNote == nil then
    return SV:finish()
  end

  focusNote(mainEditor, firstNote)

  local noteLanguageOverride = firstNote:getLanguageOverride()
  local wouldConvert = noteLanguageOverride == "" and USE_HIRAGANA or noteLanguageOverride == "japanese"
  local isLyricMode = lyric:sub(1, 1) ~= "."

  if wouldConvert and isLyricMode then
    local inputedLyrics, nextLyrics = convertRomaji(lyric .. KEY)

    if nextLyrics then
      local nextNote = selectedNotes[noteIndex + 1]

      if nextNote and nextNote:getLyrics() == "" then
        nextNote:setLyrics(nextLyrics)
      else
        inputedLyrics = inputedLyrics .. nextLyrics
      end
    end

    firstNote:setLyrics(inputedLyrics)
  else
    firstNote:setLyrics(lyric .. KEY)
  end

  return SV:finish()
end

