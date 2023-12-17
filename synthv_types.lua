---@meta
-- https://resource.dreamtonics.com/scripting/ja/index.html

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
---@field getPoints fun(s: self, begin: number, end: number): number[][] 位置が begin と end （ブリック）の間にある制御点の配列を取得します。配列の各要素は位置（ブリック）とパラメータ値からなる配列です。
---@field getType fun(s: self): AutomationTypeName この Automation のパラメータ型を取得します。Automation#getDefinition のテーブルの typeName 列を参照してください。
---@field remove fun(s: self, begin: number, end?: number): boolean 位置 begin（ブリック）と end（ブリック）の間のすべての制御点を削除します。 endを省略したときはbeginにあるものを削除します。 削除された制御点があれば真を返します。指定した範囲内に制御点がない場合は偽を返します。
---@field removeAll fun(s: self): nil Automation の制御点をすべて削除します。
---@field simplify fun(s: self, begin: number, end: number, threshold?: number): boolean 位置 begin（ブリック）から位置 end（ブリック）までのパラメータ曲線を、曲線の形状に大きく寄与しない制御点を削除することで簡素化します。threshold が指定されない場合は 0.002 が使われます。threshold の値を高くすると、より簡素化されます。 削除された制御点があれば真を返します。

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

---@class (exact) GroupSelection
---@field clearGroups fun(s: self): boolean すべての NoteGroupReference の選択を解除します。選択範囲に変更があれば真を返します。
---@field getSelectedGroups fun(s: self): NoteGroupReference[] 選択された NoteGroupReference の配列を、 選択順にしたがって取得します。
---@field hasSelectedGroups fun(s: self): boolean NoteGroupReference が1つ以上選択されているかどうか確認します。
---@field selectGroup fun(s: self, reference: NoteGroupReference): nil 選択にNoteGroupReference を追加します。 引数は、現在開いているプロジェクトに含まれている必要があります。

---@class (exact) MainEditorView: NestedObject
---@field getCurrentGroup fun(s: self): NoteGroupReference ユーザーが現在作業している NoteGroupReference を取得します。ユーザーが NoteGroupReference を開いていない場合、現在のトラックのメイングループを返します。
---@field getCurrentTrack fun(s: self): Track ピアノロールで開いている Track を取得します。
---@field getNavigation fun(s: self): CoordinateSystem ピアノロールの CoordinateSystem を取得します。
---@field getSelection fun(s: self): TrackInnerSelectionState ピアノロールの選択状態オブジェクトを取得します。

---@class (exact) NestedObject
---@field getIndexInParent fun(s: self): number 現在のオブジェクトの、親の中での添え字を取得します。Lua では、添え字は 1 から始まります。
---@field getParent fun(s: self): NestedObject | nil 親 NestedObject を取得します。現在のオブジェクトが親に付いていない場合、nil を返します。
---@field isMemoryManaged fun(s: self): boolean 現在のオブジェクトがメモリ管理されているかどうか（スクリプト環境によってガベージコレクションされるか）を確認します。

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
---@field getRapAccent fun(s: self): unknown 空の文字列を返却します。（未実装？）
---@field setRapAccent fun(s: self, rapAccent: number): unknown ？

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

---@class PlaybackControl: NestedObject
---@field getPlayhead fun(s: self): number 現在のプレイヘッドの位置を取得します（単位：秒）。 単位をブリックに変換するには、現在のプロジェクトの TimeAxis をお使いください。
---@field getStatus fun(s: self): "playing" | "looping" | "stopped" 現在のプレイバック状態を取得します。
---@field loop fun(s: self, tBegin: number, tEnd: number): nil tBegin と tEnd の間のループを開始する（単位：秒）。
---@field pause fun(s: self): nil 再生を停止しますが、プレイヘッドはリセットしません。
---@field play fun(s: self): nil オーディオの再生を開始します。
---@field seek fun(s: self, t: number): nil プレイヘッドの位置を t に設定します（単位：秒）。 オーディオが再生中の場合、一時停止はせずに、新しい位置から再生をします。
---@field stop fun(s: self): nil 再生を停止し、再生を開始した位置にプレイヘッドをリセットします。

---@class (exact) Project: NestedObject
---@field addNoteGroup fun(s: self, group: NoteGroup, suggestedIndex?: number): number プロジェクトライブラリの添え字 suggestedIndex の位置に NoteGroup を挿入します。suggestedIndexが与えられていない場合は、NoteGroup を末尾に追加します。追加された NoteGroup の添え字を返します。
---@field addTrack fun(s: self, track: Track): number Project に Track を追加します。追加された Track の添え字を返します。
---@field getDulation fun(s: self): number Project の長さ（ブリック）を取得します。最長の Track の長さとして定義されています。
---@field getFileName fun(s: self): string このプロジェクトのファイルシステム上での絶対パスを取得します。
---@field getNoteGroup fun(s: self, id: number | string): NoteGroup | nil id が数値の場合、プロジェクトライブラリの id 番目の NoteGroup を取得します。 id が文字列の場合、プロジェクトライブラリの中で id を UUID とする NoteGroup を取得します。そのような NoteGroup が存在しない場合は undefined を返します。
---@field getNumNoteGroupsInLibrary fun(s: self): number プロジェクトライブラリの NoteGroup の数を取得します。 メイングループはカウントされず、NoteGroupReference の数とは無関係です。
---@field getNumTracks fun(s: self): number トラックの数を取得します。
---@field getTimeAxis fun(s: self): TimeAxis この Project の TimeAxis オブジェクトを取得します。
---@field getTrack fun(s: self, index: number): Track 添え字が index の Track を取得します。添え字は表示順ではなく、ストレージ配置順となります。
---@field newUndoRecord fun(s:self): nil この Project に新しい編集記録を追加する。ユーザが Ctrl + Z / Ctrl + Y を押したとき、最後の編集記録に続くすべての編集が一緒に元に戻される / やり直されることを意味します。 スクリプトの実行開始時に、現在開いているプロジェクトに新しい編集記録が自動的に追加されます。
---@field removeNoteGroup fun(s: self, id: number) プロジェクトライブラリから index 番目の NoteGroup を削除します。NoteGroup を参照しているすべての NoteGroupReference も削除されます。
---@field removeTrack fun (s: self, index: number): nil Project から index 番目の Track を削除します。

---@class (exact) SelectionStateBase
---@field clearAll fun(s: self): boolean この選択状態が対応しているすべてのオブジェクトタイプについて、該当するオブジェクトの選択を解除します。選択に変更があった場合は真を返します。
---@field hasSelectedContent fun(s: self): boolean 選択されているものがあるかどうか確認します。
---@field hasUnfinishedEdits fun(s: self): boolean 選択されたオブジェクトに未完了の編集があるかどうか確認します。例えば、ユーザがいくつかのノート / 制御点をドラッグしており、まだマウスを離していない場合、真を返します。

---@class (exact) SV
---@field QUARTER number 4 分音符のブリック数（705600000）。 Synthesizer V Studio では音楽的時間（例：4 分音符、1 拍）は物理的時間（例：1 秒）とは明確に区別されています。ブリックは GUI が内部的に扱う音楽的時間の最小単位です。音楽ソフトウェアで使われる、似たような目的を持った様々な数で割り切れるように選ばれた大きな数です。名前の由来は Flicks です。
---@field blackKey fun(s: self, k: number): boolean 鍵盤（MIDI ノート番号）がピアノの黒鍵かどうかを確認します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field blick2Quarter fun(s: self, b: number): number ブリックの数 b を 4 分音符の数に変換します。 b / SV.QUARTER に相当します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field blick2Seconds fun(s: self, b: number, bpm: number): number 指定された bpm を使い、ブリックの数 b を秒に変換します。 b / SV.QUARTER * 60 / bpm に相当します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field blickRoundDiv fun(s: self, dividend: number, divisor: number): number dividend（ブリック） 割る divisor（ブリック）を丸めたもの。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field blickRoundTo fun(s: self, b: number, interval: number): number b（ブリック）に最も近い interval（ブリック）の倍数を返します。 blickRoundDiv(b, interval) * interval に相当します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field create fun(s: self, type: "Note"): Note ピッチ、歌詞、開始位置、長さなどで特徴づけられた音符。
---@field create fun(s: self, type: "Automation"): Automation NoteGroup 内の特定のパラメータタイプ（ピッチベンドなど）を制御する点の集合。
---@field create fun(s: self, type: "NoteGroup"): NoteGroup 再利用のためにグループ化されたノートやパラメータ。
---@field create fun(s: self, type: "NoteGroupReference"): NoteGroupReference 時間とピッチオフセット、および歌声 / データベースプロパティを持つ場合もある NoteGroup への参照。
---@field create fun(s: self, type: "TrackMixer"): unknown トラックのミキサーの状態（ゲイン、パン、ミュート、ソロなど）を属性の集合。
---@field create fun(s: self, type: "Track"): Track NoteGroupReference の集まり。
---@field create fun(s: self, type: "TimeAxis"): TimeAxis テンポと拍子記号を格納するプロジェクト全体規模のオブジェクト。物理的時間と音楽的時間の変換を行います。
---@field create fun(s: self, type: "Project"): Project 作業の対象となる最大のオブジェクト。Track、TimeAxis、NoteGroupなどが入っています。
---@field finish fun(s: self): nil スクリプトの終了を示します。以降のすべての非同期コールバックは実行されません。これにより、現在のスクリプトが直ちに終了するわけではないことにご注意ください。
---@field freq2Pitch fun(s: self, f: number): number 周波数（単位： Hz）を MIDI ノート番号（単位：半音、C4 は 60）に変換します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field getArrangement fun(s: self): ArrangementView トラックエリアの UI 状態オブジェクトを取得します。
---@field getHostClipboard fun(s: self): string システムクリップボードのテキストを取得します。
---@field getHostInfo fun(s: self): HostInfo OS状態オブジェクトを取得します
---@field getMainEditor fun(s: self): MainEditorView ピアノロールの UI 状態オブジェクトを取得します。
---@field getPhonemesForGroup fun(s: self, group: NoteGroupReference): string[] グループ（グループ参照として渡されます）内のすべてのノートの音素を取得します。そのグループは、現在オープンしているプロジェクトの一部である必要があります。 getPhonemesForGroup は、Synthesizer V Studio 内部の変換器（テキストから音素への）の 出力 を返すことに注意してください。つまり、ユーザが音素を指定していないノートについても getPhonemesForGroup はデフォルトの発音を返します。一方、この場合 Note#getPhonemes は空の文字列を返します。 また、変換器は別のスレッドで実行されることに注意してください。getPhonemesForGroup は現在のスレッドをブロックしません。変換器がまだグループ上での実行を完了していない場合、空の配列を返す可能性がわずかにあります。このような場合、getPhonemesForGroup を SV#setTimeout でラップすることをおすすめいたします。
---@field getPlayback fun(s: self): PlaybackControl プレイバックを制御するための UI 状態オブジェクトを取得します。
---@field getProject fun(s: self): Project 現在開いているプロジェクトを取得します。
---@field pitch2Freq fun(s: self, p: number): number MIDI ノート番号（単位：半音、C4 は 60）を周波数（単位： Hz）に変換します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field quarter2Blick fun(s: self, q: number): number 4 分音符の数 q をブリックの数に変換します。 q * SV.QUARTER に相当します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field seconds2Blick fun(s: self, s: number, bpm: number): number 指定された bpm を使い、秒 s をブリックの数に変換します。 s / 60 * bpm * SV.QUARTER に相当します。 プロジェクトの文脈においての音楽的時間と物理的時間の間の変換は、TimeAxis によって行われます。
---@field setHostClipboard fun(s: self, text: string): nil システムクリップボードにテキストを置きます。
---@field setTimeout fun(s: self, timeout: number, callback: fun(s: self): nil): nil timeOut ミリ秒後の callback 遅延呼び出しをスケジュールする。 setTimeout が呼び出された後、直ちに callback が実行されるわけではありません。コールバック関数はキューにプッシュされ遅延します。これはプリエンプティブなコールバックではありません。つまり、callback の実行によって現在実行中のタスクが中断されることはありません。
---@field showCustomDialog fun(s: self, form: CustomDialogForm): WidgetAnswers ユーザーがダイアログを閉じるまでスクリプトの実行をブロックする SV#showCustomDialogAsync の同期バージョン。ユーザーからの入力（入力済みのフォーム）を返します。
---@field showCustomDialogAsync fun(s: self, form: CustomDialogForm, callback: fun(s: self, answers: WidgetAnswers): nil): nil form で定義されたカスタムダイアログを、スクリプトの実行をブロックせずに表示します。 コールバック callback はダイアログが閉じられると呼び出されます。コールバック関数はカスタムダイアログの入力状態を取ります。
---@field showInputBox fun(s: self, title: string, message: string, defaultText: string): string ユーザーがダイアログを閉じるまでスクリプトの実行をブロックする SV#showInputBoxAsync の同期バージョン。ユーザーが入力したテキストを返します。
---@field showInputBoxAsync fun(s: self, title: string, message: string, defaultText: string, callback: fun(s: self, answer: string): nil): nil スクリプトの実行をブロックせずに、テキストボックスと「OK」ボタンのあるダイアログを表示します。 コールバック callback はダイアログが閉じられると呼び出されます。コールバック関数は、テキストボックスの内容である string 型引数をひとつ受け取ります。
---@field showMessageBox fun(s: self, title: string, message: string): nil ユーザーがメッセージボックスを閉じるまでスクリプトの実行をブロックする SV#showMessageBoxAsync の同期バージョン。
---@field showMessageBoxAsync fun(s: self, title: string, message: string, callback: (fun(s: self): nil)?): nil スクリプトの実行をブロックせずにメッセージボックスをポップアップさせます。 コールバック callback が与えられた場合、メッセージボックスが閉じられた時点で呼び出されます。コールバック関数は引数をとりません。
---@field showOkCancelBox fun(s: self, title: string, message: string): boolean ユーザーがメッセージボックスを閉じるまでスクリプトの実行をブロックする SV#showOkCancelBoxAsync の同期バージョン。「確定」ボタンが押された場合、真を返します。
---@field showOkCancelBoxAsync fun(s: self, title: string, message: string, callback: fun(s: self, answer: boolean): nil): nil スクリプトの実行をブロックせずに、「確定」ボタンと「キャンセル」ボタン付きのメッセージボックスを表示します。 メッセージボックスが閉じられると callback が呼び出されます。コールバック関数は「確定」ボタンが押された場合に真となる boolean 型引数をひとつ取ります。
---@field showYesNoCancelBox fun(s: self, title: string, message: string): YesNoCancelAnswer ユーザーがメッセージボックスを閉じるまでスクリプトの実行をブロックする SV#showYesNoCancelBoxAsync の同期バージョン。"yes"、"no"、"cancel" のいずれかを返します。
---@field showYesNoCancelBoxAsync fun(s: self, title: string, message: string, callback: fun(s: self, answer: YesNoCancelAnswer): nil): nil スクリプトの実行を妨げることなく、「はい」ボタン、「いいえ」ボタン、「キャンセル」ボタンを備えたメッセージボックスを表示します。 メッセージボックスが閉じられると callback が呼び出されます。コールバック関数は "yes"、"no"、"cancel" のいずれかとなる string 型引数をひとつ受け取ります。
---@field T fun(s: self, text: string): string 現在の UI 言語設定に基づいてローカライズされた text を取得します。

---@class (exact) TimeAxis: NestedObject
---@field addMeasureMark fun(s: self, measure: number, nomin: number, denom: number): nil measure 番目の小節に小節記号 nomin / denom を挿入します。measure 番目の小節に小節記号が存在する場合、それを更新します。
---@field addTempoMark fun(s: self, b: number, bpm: number): nil テンポ記号 bpm を b（ブリック）の位置に挿入します。bの位置にテンポ記号がある場合、BPM を更新します。
---@field getAllMeasureMarks fun(s: self): MeasureMark[] この TimeAxis 内のすべての拍子記号を取得します。
---@field getAllTempoMarks fun(s: self): TempoMark[] この TimeAxis 内のすべてのテンポ記号を取得します。
---@field getBlickFromSeconds fun(s: self, t: number): number 物理的時間 t（秒）を音楽的時間（ブリック）に変換します。
---@field getMeasureAt fun(s: self, b: number): number 位置 b（ブリック）の小節番号を取得します。
---@field getMeasureMarkAt fun(s: self, measureNumber: number): MeasureMark measureNumber 小節の拍子記号を取得します。 返されるオブジェクトには、以下のプロパティがあります。
---@field getMeasureMarkAtBlick fun(s: self): MeasureMark 位置 b（ブリック）で有効な拍子記号を取得します。
---@field getSecondsFromBlick fun(s: self, b: number): number 音楽的時間 b（ブリック）を物理的時間（秒）に変換します。
---@field getTempoMarkAt fun(s: self, b: number): TempoMark 位置 b（ブリック）で有効なテンポ記号を取得します。
---@field removeMeasureMark fun(measure: number): boolean measure 番目の小節にある小節記号を削除します。measure 番目の小節に小節記号が存在する場合、真を返します。
---@field removeTempoMark fun(b: number): boolean 位置 b（ブリック）のテンポ記号を削除します。bの位置にテンポ記号がある場合、真を返します。

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

---@class (exact) Definition
---@field displayName string
---@field typeName AutomationTypeName
---@field range number[]
---@field defaultValue number

---@class (exact) HostInfo
---@field osType "Windows" | "macOS" | "Linux" | "Unknown" "Windows", "macOS", "Linux", "Unknown" のいずれか
---@field osName string オペレーティングシステムの完全な名前
---@field hostName string "Synthesizer V Studio Pro" あるいは "Synthesizer V Studio Basic"
---@field hostVersion string Synthesizer V Studio のバージョン文字列。例： "1.0.4"
---@field hostVersionNumber number メジャー番号、マイナー番号、リビジョン番号をそれぞれ 2 桁の 16 進数で表したバージョン番号。例： "1.0.4" の場合は 0x010004
---@field languageCode string UI の言語コード。例： "en-us"、"ja-jp"、"zh-cn" など。。

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

---@alias YesNoCancelAnswer "yes" | "no" | "cancel"
---@alias CustomDialogButton "YesNoCancel" | "OkCancel"
---@alias Language "english" | "japanese" | "mandarin" | "cantonese" | nil
---@alias MusicalType "sing" | "rap"
---@alias AutomationTypeName "pitchDelta" | "vibratoEnv" | "loudness" | "tension" | "breathiness" | "voicing" | "gender"
---@alias Widget "WidgetSlider" | "WidgetComboBox" | "WidgetTextBox" | "WidgetTextArea"

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

---@class (exact) MeasureMark
---@field position number 拍子記号が置かれる小節の番号
---@field positionBlick number 拍子記号の位置（ブリック）
---@field numerator number 分子（例： 3/4 拍子の場合は 3）
---@field denominator number 分母（例： 3/4 拍子の場合は 4）

---@class (exact) TempoMark
---@field position number テンポ記号の位置（ブリック）
---@field positionSeconds number テンポ記号の位置（秒）
---@field bpm number このテンポ記号から次のテンポ記号まで有効な BPM

---@class (exact) CustomDialogForm
---@field title string ダイアログのタイトル。
---@field message string ダイアログの上部に表示されるメッセージ。
---@field buttons CustomDialogButton ダイアログの下部に表示されているプリセットボタン。 "YesNoCancel" または "OkCancel"。
---@field widgets Widget[] ダイアログの主部に表示されるウィジェットの配列。

---@class (exact) WidgetSlider
---@field name string
---@field type "Slider"
---@field label string
---@field format string
---@field minValue number
---@field maxValue number
---@field interval number
---@field default number

---@class (exact) WidgetComboBox
---@field name string
---@field type "ComboBox"
---@field label string
---@field choices string[]
---@field default number

---@class (exact) WidgetTextBox
---@field name string
---@field type "TextBox"
---@field label string
---@field default string

---@class (exact) WidgetTextArea
---@field name string
---@field type "TextArea"
---@field label string
---@field height number
---@field default string

---@class (exact) WidgetCheckBox
---@field name string
---@field type "CheckBox"
---@field label string
---@field default boolean

---@class (exact) WidgetAnswers
---@field status YesNoCancelAnswer | boolean ダイアログのボタンに対する値。
---@field answers table<string, string | number | boolean> ウィジェットの名前と値のペアのテーブル。

SV = ({} --[[@as SV]])
