; Author: Ace Who <subsistence99@gmail.com>
; Project: https://github.com/Ace-Who/AutoHotkey-HotArrow.git

#If !HotArrow_MappingState().asdw
$a::
  SendInput a
  SetTimer HotArrow_WaitKeysToChangeMappingStateOfWASD
  return
#If !HotArrow_MappingState().lkjh
$l::
  SendInput l
  SetTimer HotArrow_WaitKeysToChangeMappingStateOfHJKL
  return

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
  return
d::Right

#If HotArrow_MappingState().lkjh
k::Up
j::Down
h::Left
*l::
  SendInput {Blind}{Right}
  SetTimer HotArrow_WaitKeysToChangeMappingStateOfHJKL, -1
  return

HotArrow_MappingState() {
  static table := {}
  return table
}

HotArrow_ChangeMappingState(keys) {
  HotArrow_MappingState()[keys] := !HotArrow_MappingState()[keys]
}

HotArrow_WaitKeysToChangeMappingState(keys) {
  ; Quickly press a series of "keys" to remap/unremap them to arrow keys.
  KeyWait % SubStr(keys, 2, 1), D T0.1
  if ErrorLevel
    return
  KeyWait % SubStr(keys, 3, 1), D T0.1
  if ErrorLevel
    return
  KeyWait % SubStr(keys, 4, 1), D T0.2
  if ErrorLevel
    return
  HotArrow_ChangeMappingState(keys)
  TrayTip AutoHotkey
      , % HotArrow_MappingState()[keys]
        ? "Keys <" . keys . "> are remapped to arrow keys."
        : "Keys <" . keys . "> are UNremapped to arrow keys."
  return
}

HotArrow_WaitKeysToChangeMappingStateOfWASD:
HotArrow_WaitKeysToChangeMappingState("asdw")
return

HotArrow_WaitKeysToChangeMappingStateOfHJKL:
HotArrow_WaitKeysToChangeMappingState("lkjh")
return

