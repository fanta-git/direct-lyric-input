local KEY = "t"
local KEY_NAME = "T"
local KEY_LENGHT = {2}
local KANA_RULES = {["tt"]={"っ","t"},["nt"]={"ん","t"}}
local SLIDE_CHARS = {"ゃ","ゅ","ょ","ぁ","ぃ","ぅ","ぇ","ぉ","`"}
local LYRIC_END_CHARS = {"+","-","`"}
local NEXT_NOTE_CHAR = "/"
local VIEW_TOLERANCE = 0.1
local USE_HIRAGANA = true

---@diagnostic disable-next-line: lowercase-global
function getClientInfo()
  return {
    name = "DLIn: key-" .. KEY_NAME,
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
  local currentGroup = mainEditor:getCurrentGroup()
  local viewRangeHorizontal = coordinate:getTimeViewRange()
  local viewLeft, viewRight = viewRangeHorizontal[1], viewRangeHorizontal[2]
  local groupLeft = currentGroup:getOnset()
  local noteLeft, noteRight = note:getOnset() + groupLeft, note:getEnd() + groupLeft

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
---@return Note | nil, number, string
local function getTargetNote(noteGroup)
  if #noteGroup == 0 then
    return nil, -1, ""
  end

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

  local lastChar = prevLyric:sub(-1)
  local isEndMultiByte = (lastChar:byte() & 0xC0) == 0x80
  local isEndChar = isEndMultiByte or lastChar == NEXT_NOTE_CHAR or arrayFind(LYRIC_END_CHARS, function (char)
    return char == lastChar
  end)

  if isEndChar then
    return targetNote, targetNoteIndex, ""
  end

  return prevNote, prevIndex, prevLyricNormalized
end

---@diagnostic disable-next-line: lowercase-global
function main()
  local mainEditor = SV:getMainEditor()
  local selection = mainEditor:getSelection()
  local selectedNotes = sortNotesByIndex(selection:getSelectedNotes())
  local firstNote, noteIndex, lyric = getTargetNote(selectedNotes)
  if firstNote == nil then
    return SV:finish()
  end

  focusNote(mainEditor, firstNote)

  local noteLanguageOverride = firstNote:getLanguageOverride()
  local wouldConvert = noteLanguageOverride == "" and USE_HIRAGANA or noteLanguageOverride == "japanese"
  local isLyricMode = lyric:sub(1, 1) ~= "."

  if wouldConvert and isLyricMode then
    local inputedLyrics, nextLyrics = convertRomaji(lyric .. KEY)
    local isSlide = arrayFind(SLIDE_CHARS, function (char)
      return char == inputedLyrics
    end)

    if isSlide then
      local prevNote = selectedNotes[noteIndex - 1]
      local prevLyrics = prevNote and prevNote:getLyrics() or ""
      if #prevLyrics > 0 and (prevLyrics:byte(-1) & 0xC0) == 0x80 then
        prevNote:setLyrics(prevLyrics .. inputedLyrics)

        firstNote:setLyrics(nextLyrics or "")
        return SV:finish()
      end
    end

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

