local KEY = "r"
local KEY_NAME = "R"

package.path = '/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/direct-lyric-input/modules/?.lua'
local commons = require('commons')

---@diagnostic disable-next-line: lowercase-global
getClientInfo = commons.keysClientInfo(KEY_NAME)

---@diagnostic disable-next-line: lowercase-global
main = commons.keysMain(KEY)
