getClientInfo = getClientInfo or function () end

local USE_HIRAGANA = true

local VIEW_TOLERANCE = 0.1

local LYRIC_END = "\x80-\xBF+-"
local NEXT_NOTE_CHAR = "/"
local SLIDE_KEYS = { "l", "x", "`" }

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

-- 以下処理用

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

return {
  USE_HIRAGANA = USE_HIRAGANA,
  VIEW_TOLERANCE = VIEW_TOLERANCE,
  LYRIC_END_PATTERN = LYRIC_END_PATTERN,
  NEXT_NOTE_CHAR = NEXT_NOTE_CHAR,
  KANA_RULES = KANA_RULES,
  KEY_LENGHT = KEY_LENGHT,
  SLIDE_KEYS_SET = SLIDE_KEYS_SET,
}
