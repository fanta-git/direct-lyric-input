---@diagnostic disable-next-line: lowercase-global
function getClientInfo()
  return {
    name = "DLIn: lyric-clear-all",
    category = "Direct Lyric Input",
    author = "fanta",
    versionNumber = 1,
    minEditorVersion = 65540
  }
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

---@diagnostic disable-next-line: lowercase-global
function main()
  local mainEditor = SV:getMainEditor()
  local selectionNotes = sortNotesByIndex(mainEditor:getSelection():getSelectedNotes())
  if #selectionNotes == 0 then
    return SV:finish()
  end
  local isEveryNoteEmpty = true

  for _, note in ipairs(selectionNotes) do
    local lyric = note:getLyrics()

    if lyric ~= "" then
      note:setLyrics("")
      isEveryNoteEmpty = false
    end
  end

  if isEveryNoteEmpty then
    local currentGroup = mainEditor:getCurrentGroup():getTarget()
    for _, note in ipairs(selectionNotes) do
      currentGroup:removeNote(note:getIndexInParent())
    end
  end

  return SV:finish()
end
