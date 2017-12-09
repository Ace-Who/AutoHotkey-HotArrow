; Author: Ace Who <subsistence99@gmail.com>
; Project: https://github.com/Ace-Who/AutoHotkey-easy-switch-keymapping-to-arrows.git

#If !HotArrow_MappingState().asdw
~a::HotArrow_WaitKeysToChangeMappingState("asdw")
#If !HotArrow_MappingState().lkjh
~l::HotArrow_WaitKeysToChangeMappingState("lkjh")

#If HotArrow_MappingState().asdw
w::Up
s::Down
*a::
  SendInput {Blind}{Left}
  /* Why not call the HotArrow_WaitKeysToChangeMappingState function directly
   * is to avoid being delayed by the KeyWait commands. If delayed, holding "a"
   * won't launch this hotkey and send "Left" as frequently as supposed.
   */
  SetTimer HotArrow_WaitKeysToChangeMappingStateOfWASD, -1
  Return
d::Right

#If HotArrow_MappingState().lkjh
k::Up
j::Down
h::Left
*l::
  SendInput {Blind}{Right}
  SetTimer HotArrow_WaitKeysToChangeMappingStateOfHJKL, -1
  Return

HotArrow_MappingState() {
  static table := {}
  Return table
}

HotArrow_ChangeMappingState(keys) {
  HotArrow_MappingState()[keys] := !HotArrow_MappingState()[keys]
}

HotArrow_WaitKeysToChangeMappingState(keys) {
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
  HotArrow_ChangeMappingState(keys)
  TrayTip AutoHotkey
      , % HotArrow_MappingState()[keys]
        ? "Keys <" . keys . "> are remapped to arrow keys."
        : "Keys <" . keys . "> are UNremapped to arrow keys."
  Return
}

HotArrow_WaitKeysToChangeMappingStateOfWASD:
HotArrow_WaitKeysToChangeMappingState("asdw")
Return

HotArrow_WaitKeysToChangeMappingStateOfHJKL:
HotArrow_WaitKeysToChangeMappingState("lkjh")
Return

