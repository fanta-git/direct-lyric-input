---@meta
-- TODO: 全然書きかけ

function getClientInfo() end

---@class (exact) ArrangementSelectionState: NestedObject, SelectionStateBase, GroupSelection

---@class (exact) ArrangementView: NestedObject
---@field getNavigation fun(s: self): CoordinateSystem トラックエリアの座標系を取得します。
---@field getSelection fun(s: self): ArrangementSelectionState トラックエリアの選択状態オブジェクトを取得します。

---@class (exact) Automation: NestedObject
---@field add fun(s: self, b: number, v: number): nil 位置 b（ブリック）とパラメータ値 v の制御点を追加します。b 上にすでに制御点がある場合、パラメータ値を v に更新します。 新しく制御点が作成された場合は真を返します。
---@field clone fun(s: self): Automation 現在のオブジェクトの深いコピー。
---@field get fun(s: self, b: number): number 位置 b（ブリック）での補間されたパラメータ値を取得します。もちろん b に制御点が存在する場合、補間方法にかかわらず、その点のパラメータ値を返します。
---@field getAllPoints fun(s: self): number[] Automation#getPoints の範囲無制限バージョン。
---@field getDefinition fun(s: self): Definition 以下のプロパティを持つオブジェクトを取得します。
--- - displayName: string
--- - typeName: string
--- - range: 長さ 2 の要素が number の array
--- - defaultValue: number
---@field getInterpolationMethod fun(s: self): string 制御点間の値の補間方法を返します。
--- - "Linear" - 線形補間
--- - "Cosine" - コサイン補間
--- - "Cubic" - 修正 Catmull-Rom スプライン曲線補間
---@field getLinerar fun(s: self, b: number): number Automation#get の線形補間を使用したバージョン（たとえ Automation#getInterpolationMethod が "Linear" でない場合でも）。
---@field getPoints fun(s: self, begin: number, end: number): { [1]: number, [2]: number }[] 位置が begin と end （ブリック）の間にある制御点の配列を取得します。配列の各要素は位置（ブリック）とパラメータ値からなる配列です。
---@field getType fun(s: self): AutomationTypeName この Automation のパラメータ型を取得します。Automation#getDefinition のテーブルの typeName 列を参照してください。
-- TODO: 作業途中

---@class (exact) Definition
---@field displayName string
---@field typeName AutomationTypeName
---@field range { [1]: number, [2]: number }
---@field defaultValue number

---@class (exact) SynthV
---@field QUARTER integer
---@field blackKey fun(s: self, k: number): boolean
---@field blick2Quarter fun(s: self, b: number): number
---@field blick2Seconds fun(s: self, b: number, bpm: number): number
---@field blickRoundDiv fun(s: self, dividend: number, divisor: number): number
---@field blickRoundTo fun(s: self, b: number, interval: number): number
---@field create fun(s: self, type: 'Note'): Note
---@field create fun(s: self, type: 'Automation'): Automation
---@field create fun(s: self, type: 'NoteGroup'): NoteGroup
---@field create fun(s: self, type: 'NoteGroupReference'): NoteGroupReference
---@field create fun(s: self, type: 'TrackMixer'): {}
---@field create fun(s: self, type: 'Track'): Track
---@field create fun(s: self, type: 'TimeAxis'): TimeAxis
---@field create fun(s: self, type: 'Project'): Project
---@field finish fun(s: self): nil
---@field freq2Pitch fun(s: self, f: number): number
---@field getArrangement fun(s: self): ArrangementView
---@field getHostClipboard fun(s: self): string
---@field getHostInfo fun(s: self): HostInfo
---@field getMainEditor fun(s: self): MainEditorView
---@field getPhonemesForGroup fun(s: self, group: NoteGroupReference): string[]
---@field getPlayback fun(s: self): PlaybackControl
---@field getProject fun(s: self): Project
---@field pitch2Freq fun(s: self, p: number): number
---@field quarter2Blick fun(s: self, q: number): number
---@field seconds2Blick fun(s: self, s: number, bpm: number): number
---@field setHostClipboard fun(s: self, text: string): nil
---@field setTimeout fun(s: self, timeout: number, callback: fun(s: self): nil): nil;
---@field showCustomDialog fun(s: self, form: CustomDialogForm): WidgetAnswers
---@field showCustomDialogAsync fun(s: self, form: CustomDialogForm, callback: fun(s: self, answers: WidgetAnswers): nil): nil
---@field showInputBox fun(s: self, title: string, message: string, defaultText: string): string
---@field showInputBoxAsync fun(s: self, title: string, message: string, defaultText: string, callback: fun(s: self, answer: string): nil): nil
---@field showMessageBox fun(s: self, title: string, message: string): nil
---@field showMessageBoxAsync fun(s: self, title: string, message: string, callback: (fun(s: self): nil) | nil): nil
---@field showOkCancelBox fun(s: self, title: string, message: string): boolean
---@field showOkCancelBoxAsync fun(s: self, title: string, message: string, callback: fun(s: self, answer: boolean): nil): nil
---@field showYesNoCancelBox fun(s: self, title: string, message: string): YesNoCancelAnswer
---@field showYesNoCancelBoxAsync fun(s: self, title: string, message: string, callback: fun(s: self, answer: YesNoCancelAnswer): nil): nil
---@field T fun(s: self, text: string): string

---@class (exact) HostInfo
---@field osType "Windows" | "macOS" | "Linux" | "Unknown" "Windows", "macOS", "Linux", "Unknown" のいずれか
---@field osName string オペレーティングシステムの完全な名前
---@field hostName string "Synthesizer V Studio Pro" あるいは "Synthesizer V Studio Basic"
---@field hostVersion string Synthesizer V Studio のバージョン文字列。例： "1.0.4"
---@field hostVersionNumber number メジャー番号、マイナー番号、リビジョン番号をそれぞれ 2 桁の 16 進数で表したバージョン番号。例： "1.0.4" の場合は 0x010004
---@field languageCode string UI の言語コード。例： "en-us"、"ja-jp"、"zh-cn" など。

---@alias YesNoCancelAnswer 'yes' | 'no' | 'cancel'
---@alias Language 'english' | 'japanese' | 'mandarin' | 'cantonese' | nil
---@alias MusicalType 'sing' | 'rap'
---@alias AutomationTypeName 'pitchDelta' | 'vibratoEnv' | 'loudness' | 'tension' | 'breathiness' | 'voicing' | 'gender'

---@class (exact) NestedObject
---@field getIndexInParent fun(s: self): number 現在のオブジェクトの、親の中での添え字を取得します。Lua では、添え字は 1 から始まります。
---@field getParent fun(s: self): NestedObject | nil 親 NestedObject を取得します。現在のオブジェクトが親に付いていない場合、nil を返します。
---@field isMemoryManaged fun(s: self): boolean 現在のオブジェクトがメモリ管理されているかどうか（スクリプト環境によってガベージコレクションされるか）を確認します。

---@class (exact) CoordinateSystem: NestedObject
---@field getTimePxPerUnit fun(s: self): number 水平方向の拡大率を取得します。 単位は 1 ブリックあたりの画素数なので、非常に小さな数字になります。
---@field getTimeViewRange fun(s: self): { ["1"]: number, ["2"]: number } 現在表示されている時間範囲を取得します。開始時刻と終了時刻に対応する2つの number 要素を持つ配列を返します。時間の単位はブリックです。
---@field getValuePxPerUnit fun(s: self): number 鉛直方向の拡大率を取得します。 ピアノロールの場合、単位は半音あたりの画素数です。
---@field getValueViewRange fun(s: self): { ["1"]: number, ["2"]: number } 現在表示されている値の範囲を取得します。下限と上限に対応する2つの number 要素を持つ配列を返します。ピアノロールの場合、単位はMIDIノート番号です。
---@field setTimeLeft fun(s: self, time: number): nil 左端が time になるように表示範囲を移動します。
---@field setTimeRight fun(s: self, time: number): nil 右端が time になるように表示範囲を移動します。
---@field setTimeScale fun(s: self, scale: number): nil 水平方向の拡大率を scale に設定します。 単位は 1 ブリックあたりの画素数なので、非常に小さな数字になります。
---@field setValueCenter fun(s: self, v:number): nil 鉛直方向の中心が v になるように表示範囲を移動します。
---@field snap fun(s: self, b: number): number スナップ設定に基づいて時間位置 b を丸めます。
---@field t2x fun(s: self, t: number): number 時間位置を x 位置（ピクセル）に変換します。
---@field v2y fun(s: self, v: number): number 値を y 位置（ピクセル）に変換します。
---@field x2t fun(s: self, x: number): number x 位置（ピクセル）を時間位置に変換します。
---@field y2v fun(s: self, y: number): number y 位置（ピクセル）を値に変換します。

---@class (exact) SelectionStateBase
---@field clearAll fun(s: self): boolean この選択状態が対応しているすべてのオブジェクトタイプについて、該当するオブジェクトの選択を解除します。選択に変更があった場合は真を返します。
---@field hasSelectedContent fun(s: self): boolean 選択されているものがあるかどうか確認します。
---@field hasUnfinishedEdits fun(s: self): boolean 選択されたオブジェクトに未完了の編集があるかどうか確認します。例えば、ユーザがいくつかのノート / 制御点をドラッグしており、まだマウスを離していない場合、真を返します。

---@class (exact) GroupSelection
---@field clearGroups fun(s: self): boolean すべての NoteGroupReference の選択を解除します。選択範囲に変更があれば真を返します。
---@field getSelectedGroups fun(s: self): NoteGroupReference[] 選択された NoteGroupReference の配列を、 選択順にしたがって取得します。
---@field hasSelectedGroups fun(s: self): boolean NoteGroupReference が1つ以上選択されているかどうか確認します。
---@field selectGroup fun(s: self, reference: NoteGroupReference): nil 選択にNoteGroupReference を追加します。 引数は、現在開いているプロジェクトに含まれている必要があります。

---@class (exact) NoteAttributes
---@field tF0Offset? number ピッチ推移 - タイミング（秒）
---@field tF0Left? number ピッチ推移 - 長さ左（秒）
---@field tF0Right? number ピッチ推移 - 長さ右（秒）
---@field dF0Left? number ピッチ推移 - 深さ左（半音）
---@field dF0Right? number ピッチ推移 - 深さ右（半音）
---@field tF0VbrStart? number ビブラート - 開始タイミング（秒）
---@field tF0VbrLeft? number ビブラート - 左（秒）
---@field tF0VbrRight? number ビブラート - 右（秒）
---@field dF0Vbr? number ビブラート - 深さ（半音）
---@field pF0Vbr? number ビブラート - 位相（ラジアン、-π から π まで）
---@field fF0Vbr? number ビブラート - 周波数（Hz）
---@field tNoteOffset? number タイミングと音素 - ノートオフセット（秒）
---@field exprGroup? string 表現グループ
---@field dur? number[] 音素長スケーリング用の要素の配列
---@field alt? number[] 代替発音用の要素の配列

---@class (exact) Voice
---@field tF0Left? number ピッチ - 長さ左（秒）
---@field tF0Right? number ピッチ - 長さ右（秒）
---@field dF0Left? number ピッチ - 深さ左（半音）
---@field dF0Right? number ピッチ - 深さ右（半音）
---@field tF0VbrStart? number ビブラート - 開始タイミング（秒）
---@field tF0VbrLeft? number ビブラート - 左（秒）
---@field tF0VbrRight? number ビブラート - 右（秒）
---@field dF0Vbr? number ビブラート - 深さ（半音）
---@field fF0Vbr? number ビブラート - 周波数（Hz）
---@field paramLoudness? number パラメータ - ラウドネス（dB）
---@field paramTension? number パラメータ - テンション
---@field paramBreathiness? number パラメータ - ブレス
---@field paramGender? number パラメータ - ジェンダー
---@field paramToneShift? number パラメータ - トーンシフト（cents）

---@class (exact) Note : NestedObject
---@field clone fun(s: self): Note 現在のオブジェクトの深いコピー。
---@field getAttributes fun(s: self): NoteAttributes ノートのプロパティを保持するオブジェクトを取得します。
---@field getDuration fun(s: self): number ノートの長さを取得します。単位はブリックです。
---@field getEnd fun(s: self): number ノートの終了位置（開始位置＋長さ）を取得します。単位はブリックです。
---@field getLyrics fun(s: self): string 現在のノートの歌詞を取得します。
---@field getOnset fun(s: self): number ノートの開始位置を取得します。単位はブリックです。
---@field getPhonemes fun(s: self): string ユーザがノートに設定した音素をスペース区切りで返します。例： "hh ah ll ow" 。 音素が設定されていない場合は、デフォルトの発音ではなく空の文字列を返します
---@field getPitch fun(s: self): number ピッチを MIDI ノート番号で取得します。C4 は 60 に対応します。
---@field setAttributes fun(s: self, attributes: NoteAttributes): nil 属性オブジェクトに基づいてノートプロパティを設定します。属性オブジェクトは完全である必要はありません。与えられたプロパティのみが更新されます。
---@field setDuration fun(s: self, t: number): nil ノートの長さを t に変更します。単位はブリックです。終了位置も変更されますが、開始位置は変更されません。
---@field setLyrics fun(s: self, lyrics: string): nil 歌詞を lyrics に変更します。
---@field setOnset fun(s: self, t: number): nil ノートの開始位置を t に変更します。単位はブリックです。長さは変わりません。
---@field setPhonemes fun(s: self, phonemes_str: string): nil 音素を phoneme_str に変更します。例： "hh ah ll ow " 。
---@field setTimeRange fun(s: self, onset: number, duration: number): nil 開始位置と長さの両方を設定します。setOnset(onset) と setDuration(duration) の両方を呼び出すのと同じです。
---@field getMusicalType fun(s: self): MusicalType ノートのピッチモード（歌唱/ラップ）を取得します。
---@field setMusicalType fun(s: self, musicalType: MusicalType): nil ノートのピッチモード（歌唱/ラップ）を設定します。
---@field getLanguageOverride fun(s: self): Language ユーザーがノートに設定した言語を取得します。未設定（グループに準ずる）の場合は""を返します。
---@field setLanguageOverride fun(s: self, language: Language): nil ユーザーがノートに設定した言語を設定します。nil を渡すと、言語設定をグループに同期する未設定状態になります。
---@field getPitchAutoMode fun(s: self): boolean ピッチの自動調整が有効かどうかを確認します。
---@field setPitchAutoMode fun(s: self, pitchAutoMode: boolean): nil ピッチの自動調整を有効にするかどうかを設定します。
---@field getRapAccent fun(s: self): unknown 空の文字列を返却します。（ハリボテ？）
---@field setRapAccent fun(s: self, rapAccent: number): unknown ？

---@class (exact) MainEditorView: NestedObject
---@field getCurrentGroup fun(s: self): NoteGroupReference ユーザーが現在作業している NoteGroupReference を取得します。ユーザーが NoteGroupReference を開いていない場合、現在のトラックのメイングループを返します。
---@field getCurrentTrack fun(s: self): Track ピアノロールで開いている Track を取得します。
---@field getNavigation fun(s: self): CoordinateSystem ピアノロールの CoordinateSystem を取得します。
---@field getSelection fun(s: self): TrackInnerSelectionState ピアノロールの選択状態オブジェクトを取得します。

---@class (exact) TrackInnerSelectionState: NestedObject, SelectionStateBase, GroupSelection
---@field clearAll fun(s: self): boolean この選択状態が対応しているすべてのオブジェクトタイプについて、該当するオブジェクトの選択を解除します。選択に変更があった場合は真を返します。
---@field claarGroups fun(s: self): boolean すべての NoteGroupReference の選択を解除します。選択範囲に変更があれば真を返します。
---@field clearNotes fun(s: self): boolean すべてのノートの選択を解除します。選択範囲に変更があれば真を返します。
---@field getSelectedGroups fun(s: self): NoteGroupReference[] 選択された NoteGroupReference の配列を、 選択順にしたがって取得します。
---@field getSelectedNotes fun(s: self): Note[] 選択されたノートの配列を、 選択順にしたがって取得します。
---@field hasSelectedContent fun(s: self): boolean 選択されているものがあるかどうか確認します。
---@field hasSelectedGroups fun(s: self): boolean NoteGroupReference が1つ以上選択されているかどうか確認します。
---@field hasSelectedNotes fun(s: self): boolean Note が1つ以上選択されているかどうか確認します。
---@field hasUnfinishedEdits fun(s: self): boolean 選択されたオブジェクトに未完了の編集があるかどうか確認します。例えば、ユーザがいくつかのノート / 制御点をドラッグしており、まだマウスを離していない場合、真を返します。

---@class (exact) Track: NestedObject
---@field addGroupReference fun(s: self, group: NoteGroupReference): number この Track に NoteGroupReference を追加し、その添え字を返します。開始位置についてソートされた状態を保持します。
---@field clone fun(s: self): Track 現在のオブジェクトの深いコピー。
---@field getDisplayColor fun(s: self): string トラックの色を16進数文字列として取得します。
---@field getDisplayOrder fun(s: self): number 親 Project 内でのこのトラックの表示順位を取得します。トラックの表示順は、そのストレージインデックスとは異なる場合があります。トラックエリアで表示されるトラックの順番は、常にこの表示順位をもとにしたものになります。
---@field getDuration fun(s: self): number Track の長さ（ブリック）を取得します。最後の NoteGroupReference の終了位置として定義されています。
---@field getGroupReference fun(s: self, index: number): NoteGroupReference 添え字が index の NoteGroupReference を取得します。1 番目は常にメイングループです。その後にプロジェクトライブラリの NoteGroup への参照が続きます。開始位置について昇順でソートされています。
---@field getName fun(s: self): string トラック名を取得します。
---@field getNumGroups fun(s: self): number この Track に含まれる NoteGroupReference の数を取得します。メイングループも数えられます。
---@field isBounced fun(s: self): boolean レンダリングパネルに表示されるファイルに書き出すかどうか確認します。
---@field removeGroupReference fun(s: self, index: number): nil この Track から index 番目の NoteGroupReference を削除します。
---@field setBounced fun(s: self, enabled: boolean): nil Track をファイルに書き出すかどうか設定します。Track#isBounced を参照してください。
---@field setDisplayColor fun(s: self, color: string): nil Track の表示色を設定します（引数：16進文字列）。
---@field setName fun(s: self, name: string): nil Track の名前を設定します。

---@class (exact) NoteGroupReference: NestedObject
---@field clone fun(s: self): NoteGroupReference 現在のオブジェクトの深いコピー。
---@field getDuration fun(s: self): number 現在の NoteGroupReference の長さ（ブリック）。 getEnd() - getOnset() に等しいです。
---@field getEnd fun(s: self): number 終了位置（ブリック）、つまり、対象 NoteGroup の最後のノートの終了位置に時間オフセットを加えたものを取得します。
---NoteGroupReference がオーディオファイル（NoteGroupReference#isInstrumental）を保持している場合、getEnd() はオーディオの終了位置（ブリック）に時間オフセットを加えたものを返します。ただし、NoteGroupReference が Project の中に配置されていない場合、オーディオの長さを音楽的に意味のある時間単位で決定するのに情報が十分でなく、getEnd() は長さがオーディオの長さが 0 であると仮定してしまいます。
---@field getOnset fun(s: self): number 開始位置（ブリック）、つまり、対象 NoteGroup の最初のノートの開始位置に時間オフセットを加えたものを取得します。
---@field getPitchOffset fun(s: self): number 対象 NoteGroup 内のすべてのノートに適用されるピッチシフト（半音）を取得します。
---@field getTarget fun(s: self): NoteGroup 参照対象の NoteGroup を取得します。
---@field getTimeOffset fun(s: self): number 対象 NoteGroup 内のすべてのノートに適用される時間オフセット（ブリック）を取得します。
---@field getVoice fun(s: self): Voice 現在のグループのデフォルト歌声プロパティを保持するオブジェクトを取得します。Note#getAttributes と同様です。
---@field isInstrumental fun(s: self): boolean この NoteGroupReference が外部のオーディオファイルを参照しているかどうか。そうである場合、NoteGroup は参照対象とならない。
---@field setPitchOffset fun(s: self, pitchOffset: number): nil ピッチオフセットを pitchOffset （半音）に設定する。
---@field setTarget fun(s: self, target: NoteGroup): nil 参照対象の NoteGroup を設定します。 一度設定した参照対象は変更できないことに注意してください。
---@field setTimeOffset fun(s: self, timeOffset: number): nil 時間オフセットを timeOffset （ブリック）に設定します。
---@field setVoice fun(s: self, attributes: Voice): nil 属性オブジェクトに基づいて歌声プロパティを設定します（NoteGroupReference#getVoice を参照）。属性オブジェクトは完全である必要はありません。与えられたプロパティのみが更新されます（Note#setAttributes を参照）。

---@class (exact) NoteGroup: NestedObject
---@field addNote fun(s: self, note: Note): number この NoteGroup にノートを追加し、追加したノートの添え字を返します。ノートは、開始位置について昇順にソートされています。
---@field clone fun(s: self): NoteGroup 現在のオブジェクトの深いコピー。
---@field getName fun(s: self): string ユーザが設定したこの NoteGroup の名前を取得する。
---@field getNote fun(s: self, index: number): Note 添え字が index のノートを取得します。NoteGroup 内のノートは常に開始位置の順でソートされます。
---@field getNumNotes fun(s: self): number NoteGroup のノートの数を取得します。
---@field getParameter fun(s: self, type: AutomationTypeName): Automation | nil パラメータ type の Automation オブジェクトを取得します。
---@field getUUID fun(s: self): string Universally Unique Identifier を取得します。名前とは違い、UUID はプロジェクト全体で一意なので、NoteGroupReference と NoteGroup を関連付けるために使用することができます。 UUIDは次のようなものになります： "ab85d637-d80b-4628-9c27-007ea74029af" 。
---@field removeNote fun(s: self, index: number): nil 添え字が index のノートを削除します。
---@field setName fun(s: self, name: string): nil この NoteGroup の名前を設定します。
