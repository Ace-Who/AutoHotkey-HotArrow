#If !remappedToArrowKeys("asdw")
~a::waitKeysToChangeRemappingToArrowKeys("asdw")
#If !remappedToArrowKeys("lkjh")
~l::waitKeysToChangeRemappingToArrowKeys("lkjh")

#If remappedToArrowKeys("asdw")
w::Up
s::Down
*a::
  SendInput {Blind}{Left}
  /* Why not call the waitKeysToChangeRemappingToArrowKeys function directly is
   * to avoid being delayed by the KeyWait commands. If delayed, holding "a"
   * won't launch this hotkey and send "Left" as frequently as supposed.
   */
  SetTimer waitKeysToChangeRemappingToArrowKeysFromWASD, -1
  Return
d::Right

#If remappedToArrowKeys("lkjh")
k::Up
j::Down
h::Left
*l::
  SendInput {Blind}{Right}
  SetTimer waitKeysToChangeRemappingToArrowKeysFromHJKL, -1
  Return

remappedToArrowKeys(keys, toggle := 0) {
  static table := {}
  if (toggle) {
    table[keys] := !table[keys]
  }
  Return table[keys]
}

waitKeysToChangeRemappingToArrowKeys(keys) {
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
  remappedToArrowKeys(keys, 1)
  TrayTip AutoHotkey
      , % remappedToArrowKeys(keys)
        ? "Keys <" . keys . "> are remapped to arrow keys."
        : "Keys <" . keys . "> are UNremapped to arrow keys."
  Return
}

waitKeysToChangeRemappingToArrowKeysFromWASD:
waitKeysToChangeRemappingToArrowKeys("asdw")
Return

waitKeysToChangeRemappingToArrowKeysFromHJKL:
waitKeysToChangeRemappingToArrowKeys("lkjh")
Return

