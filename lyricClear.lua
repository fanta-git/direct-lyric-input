package.path = '/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/direct-lyric-input/modules/?.lua'
local commons = require('commons')

---@diagnostic disable-next-line: lowercase-global
function getClientInfo()
  return {
    name = "DLIn: lyric-clear",
    category = "Direct Lyric Input",
    author = "fanta",
    versionNumber = 1,
    minEditorVersion = 65540
  }
end

---@diagnostic disable-next-line: lowercase-global
function main()
  local mainEditor = SV:getMainEditor()
  local selectedNotes = commons.sortNotesByIndex(mainEditor:getSelection():getSelectedNotes())
  if #selectedNotes == 0 then
    return SV:finish()
  end

  for i = #selectedNotes, 1, -1 do
    local note = selectedNotes[i]
    local lyric = note:getLyrics()

    if lyric ~= "" then
      local subbed = lyric:sub(1, utf8.offset(lyric, -1) - 1)
      note:setLyrics(subbed)
      commons.focusNote(mainEditor, (subbed == "") and selectedNotes[i - 1] or note)

      return SV:finish()
    end
  end

  local currentGroup = mainEditor:getCurrentGroup():getTarget()
  for _, note in ipairs(selectedNotes) do
    currentGroup:removeNote(note:getIndexInParent())
  end

  return SV:finish()
end

return { test = "test" }