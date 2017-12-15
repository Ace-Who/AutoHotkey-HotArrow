; Author: Ace Who <subsistence99@gmail.com>
; Project: https://github.com/Ace-Who/AutoHotkey-HotArrow.git

#If !HotArrow_MappingState().wasd
~a & ~w::HotArrow_WaitKeysToChangeMappingState("wasd")
~w & ~a::HotArrow_WaitKeysToChangeMappingState("wasd")
#If !HotArrow_MappingState().lkjh
~l & ~h::HotArrow_WaitKeysToChangeMappingState("hljk")
~h & ~l::HotArrow_WaitKeysToChangeMappingState("hljk")

#If HotArrow_MappingState().wasd
w::Up
s::Down
a::Left
d::Right
~a & ~w::HotArrow_WaitKeysToChangeMappingState("wasd")
~w & ~a::HotArrow_WaitKeysToChangeMappingState("wasd")

#If HotArrow_MappingState().hljk
k::Up
j::Down
h::Left
l::Right
~l & ~h::HotArrow_WaitKeysToChangeMappingState("hljk")
~h & ~l::HotArrow_WaitKeysToChangeMappingState("hljk")

HotArrow_MappingState() {
  static table := {}
  return table
}

HotArrow_ChangeMappingState(keys) {
  HotArrow_MappingState()[keys] := !HotArrow_MappingState()[keys]
}

HotArrow_WaitKeysToChangeMappingState(keys) {
  ; Quickly press a series of "keys" to remap/unremap them to arrow keys.
  KeyWait % SubStr(keys, 3, 1), D T0.2
  if ErrorLevel
    return
  KeyWait % SubStr(keys, 4, 1), D T0.1
  if ErrorLevel
    return
  HotArrow_ChangeMappingState(keys)
  TrayTip AutoHotkey
      , % HotArrow_MappingState()[keys]
        ? "Keys <" . keys . "> are remapped to arrow keys."
        : "Keys <" . keys . "> are UNremapped to arrow keys."
  return
}
