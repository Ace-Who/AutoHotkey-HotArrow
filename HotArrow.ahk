; Author: Ace Who <subsistence99@gmail.com>
; Project: https://github.com/Ace-Who/AutoHotkey-easy-switch-keymapping-to-arrows.git

#If !HotArrow#MappingState("asdw")
~a::HotArrow#WaitKeysToChangeMappingState("asdw")
#If !HotArrow#MappingState("lkjh")
~l::HotArrow#WaitKeysToChangeMappingState("lkjh")

#If HotArrow#MappingState("asdw")
w::Up
s::Down
*a::
  SendInput {Blind}{Left}
  /* Why not call the HotArrow#WaitKeysToChangeMappingState function directly is
   * to avoid being delayed by the KeyWait commands. If delayed, holding "a"
   * won't launch this hotkey and send "Left" as frequently as supposed.
   */
  SetTimer HotArrow#WaitKeysToChangeMappingStateOfWASD, -1
  Return
d::Right

#If HotArrow#MappingState("lkjh")
k::Up
j::Down
h::Left
*l::
  SendInput {Blind}{Right}
  SetTimer HotArrow#WaitKeysToChangeMappingStateOfHJKL, -1
  Return

HotArrow#MappingState(keys, toggle := 0) {
  static table := {}
  if (toggle) {
    table[keys] := !table[keys]
  }
  Return table[keys]
}

HotArrow#WaitKeysToChangeMappingState(keys) {
  ; Quickly press a series of "keys" to remap/unremap them to arrow keys.
  KeyWait % SubStr(keys, 2, 1), D T0.1
  if ErrorLevel
    Return
  KeyWait % SubStr(keys, 3, 1), D T0.1
  if ErrorLevel
    Return
  KeyWait % SubStr(keys, 4, 1), D T0.2
  if ErrorLevel
    Return
  HotArrow#MappingState(keys, 1)
  TrayTip AutoHotkey
      , % HotArrow#MappingState(keys)
        ? "Keys <" . keys . "> are remapped to arrow keys."
        : "Keys <" . keys . "> are UNremapped to arrow keys."
  Return
}

HotArrow#WaitKeysToChangeMappingStateOfWASD:
HotArrow#WaitKeysToChangeMappingState("asdw")
Return

HotArrow#WaitKeysToChangeMappingStateOfHJKL:
HotArrow#WaitKeysToChangeMappingState("lkjh")
Return

