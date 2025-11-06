; ===== SmartAutoAction by landn.thrn =====
#SingleInstance Force
#UseHook
SendMode "Input"
SetWorkingDir A_ScriptDir

; Increase hotkey limit to prevent "too many hotkeys" warning
; Default is 70, increasing to 200 to handle rapid key presses during auto-repeat
A_MaxHotkeysPerInterval := 200

; TUNE THESE:
refreshMs := 15          ; resend key every N ms (10–20 is smooth; lower = stronger hold)

SetKeyDelay -1, -1

autoRepeat := false
currentKey := ""
isWKey := false
isShiftQ := false

OnExit(ReleaseKeys)
ReleaseKeys(*) {
    if (currentKey != "") {
        if (currentKey = "w") {
            ; For W key, release both Shift and W
    Send("{w up}")
    Send("{Shift up}")
        } else {
            ; For other keys, just release the key
            Send("{" . currentKey . " up}")
        }
    }
}

; Shift + Q for auto-sprint (same as F1 + W)
+q:: {
    ; Since Shift is already held when this hotkey triggers, we need to handle it specially
    global autoRepeat, currentKey, isWKey, isShiftQ, refreshMs
    if autoRepeat
        StopAutoRepeat()
    
    autoRepeat := true
    currentKey := "w"
    isWKey := true
    isShiftQ := true
    
    ; For Shift + Q, Shift is already held, so just hold W
    Send("{w down}")
    SetTimer(HoldKeyRefresh, refreshMs)
}

; F1 + any key to start auto-repeat
F1 & a:: StartAutoRepeat("a")
F1 & b:: StartAutoRepeat("b")
F1 & c:: StartAutoRepeat("c")
F1 & d:: StartAutoRepeat("d")
F1 & e:: StartAutoRepeat("e")
F1 & f:: StartAutoRepeat("f")
F1 & g:: StartAutoRepeat("g")
F1 & h:: StartAutoRepeat("h")
F1 & i:: StartAutoRepeat("i")
F1 & j:: StartAutoRepeat("j")
F1 & k:: StartAutoRepeat("k")
F1 & l:: StartAutoRepeat("l")
F1 & m:: StartAutoRepeat("m")
F1 & n:: StartAutoRepeat("n")
F1 & o:: StartAutoRepeat("o")
F1 & p:: StartAutoRepeat("p")
F1 & q:: StartAutoRepeat("q")
F1 & r:: StartAutoRepeat("r")
F1 & s:: StartAutoRepeat("s")
F1 & t:: StartAutoRepeat("t")
F1 & u:: StartAutoRepeat("u")
F1 & v:: StartAutoRepeat("v")
F1 & w:: StartAutoRepeat("w")
F1 & x:: StartAutoRepeat("x")
F1 & y:: StartAutoRepeat("y")
F1 & z:: StartAutoRepeat("z")
F1 & `:: StartAutoRepeat("``")
F1 & Space:: StartAutoRepeat("Space")
F1 & Enter:: StartAutoRepeat("Enter")
F1 & Tab:: StartAutoRepeat("Tab")
F1 & Shift:: StartAutoRepeat("Shift")
F1 & Ctrl:: StartAutoRepeat("Ctrl")
F1 & Alt:: StartAutoRepeat("Alt")
F1 & CapsLock:: StartAutoRepeat("CapsLock")
F1 & Esc:: StartAutoRepeat("Esc")

; F1 + mouse buttons to start auto-repeat
F1 & LButton:: StartAutoRepeat("LButton")
F1 & RButton:: StartAutoRepeat("RButton")
F1 & MButton:: StartAutoRepeat("MButton")
F1 & XButton1:: StartAutoRepeat("XButton1")
F1 & XButton2:: StartAutoRepeat("XButton2")

; F1 + number keys to start auto-repeat
F1 & 0:: StartAutoRepeat("0")
F1 & 1:: StartAutoRepeat("1")
F1 & 2:: StartAutoRepeat("2")
F1 & 3:: StartAutoRepeat("3")
F1 & 4:: StartAutoRepeat("4")
F1 & 5:: StartAutoRepeat("5")
F1 & 6:: StartAutoRepeat("6")
F1 & 7:: StartAutoRepeat("7")
F1 & 8:: StartAutoRepeat("8")
F1 & 9:: StartAutoRepeat("9")

; F1 + F keys to start auto-repeat (F2-F24)
F1 & F2:: StartAutoRepeat("F2")
F1 & F3:: StartAutoRepeat("F3")
F1 & F4:: StartAutoRepeat("F4")
F1 & F5:: StartAutoRepeat("F5")
F1 & F6:: StartAutoRepeat("F6")
F1 & F7:: StartAutoRepeat("F7")
F1 & F8:: StartAutoRepeat("F8")
F1 & F9:: StartAutoRepeat("F9")
F1 & F10:: StartAutoRepeat("F10")
F1 & F11:: StartAutoRepeat("F11")
F1 & F12:: StartAutoRepeat("F12")
F1 & F13:: StartAutoRepeat("F13")
F1 & F14:: StartAutoRepeat("F14")
F1 & F15:: StartAutoRepeat("F15")
F1 & F16:: StartAutoRepeat("F16")
F1 & F17:: StartAutoRepeat("F17")
F1 & F18:: StartAutoRepeat("F18")
F1 & F19:: StartAutoRepeat("F19")
F1 & F20:: StartAutoRepeat("F20")
F1 & F21:: StartAutoRepeat("F21")
F1 & F22:: StartAutoRepeat("F22")
F1 & F23:: StartAutoRepeat("F23")
F1 & F24:: StartAutoRepeat("F24")

; F1 + punctuation and symbol keys to start auto-repeat
F1 & ,:: StartAutoRepeat(",")
F1 & .:: StartAutoRepeat(".")
F1 & /:: StartAutoRepeat("/")
F1 & `;:: StartAutoRepeat(";")
F1 & ':: StartAutoRepeat("'")
F1 & [:: StartAutoRepeat("[")
F1 & ]:: StartAutoRepeat("]")
F1 & \:: StartAutoRepeat("\")
F1 & -:: StartAutoRepeat("-")
F1 & =:: StartAutoRepeat("=")

; F1 + navigation keys to start auto-repeat
F1 & Home:: StartAutoRepeat("Home")
F1 & End:: StartAutoRepeat("End")
F1 & PgUp:: StartAutoRepeat("PgUp")
F1 & PgDn:: StartAutoRepeat("PgDn")
F1 & Up:: StartAutoRepeat("Up")
F1 & Down:: StartAutoRepeat("Down")
F1 & Left:: StartAutoRepeat("Left")
F1 & Right:: StartAutoRepeat("Right")
F1 & Delete:: StartAutoRepeat("Delete")
F1 & Pause:: StartAutoRepeat("Pause")
F1 & PrintScreen:: StartAutoRepeat("PrintScreen")

; Refresh current key so games treat it as continuously held
HoldKeyRefresh() {
    global autoRepeat, currentKey, isWKey, isShiftQ
    if autoRepeat && currentKey != ""
        if (isWKey) {
            ; For W key, refresh both Shift and W (hold for movement)
            if (isShiftQ) {
                ; Shift + Q: Shift is already held, just refresh W
                Send("{w down}")
            } else {
                ; F1 + W: need to hold both Shift and W
                Send("{Shift down}")
                Send("{w down}")
            }
        } else {
            ; For other keys, send key press and release (tap for actions)
            Send("{" . currentKey . " down}")
            Send("{" . currentKey . " up}")
        }
}

; Cancel auto-repeat for ALL keys (including mouse buttons)
~*a::      CancelRepeat()
~*b::      CancelRepeat()
~*c::      CancelRepeat()
~*d::      CancelRepeat()
~*e::      CancelRepeat()
~*f::      CancelRepeat()
~*g::      CancelRepeat()
~*h::      CancelRepeat()
~*i::      CancelRepeat()
~*j::      CancelRepeat()
~*k::      CancelRepeat()
~*l::      CancelRepeat()
~*m::      CancelRepeat()
~*n::      CancelRepeat()
~*o::      CancelRepeat()
~*p::      CancelRepeat()
~*q::      CancelRepeat()
~*r::      CancelRepeat()
~*s::      CancelRepeat()
~*t::      CancelRepeat()
~*u::      CancelRepeat()
~*v::      CancelRepeat()
~*w::      ; W key does NOT cancel auto-repeat
~*x::      CancelRepeat()
~*y::      CancelRepeat()
~*z::      CancelRepeat()
~*`::      CancelRepeat()  ; Backtick/grave accent key
~*Space::  CancelRepeat()
~*Enter::  CancelRepeat()
~*Tab::    CancelRepeat()
~*Shift::  CancelRepeat()
~*Ctrl::   CancelRepeat()
~*Alt::    CancelRepeat()
~*CapsLock:: CancelRepeat()
~*Esc::    CancelRepeat()
~*LButton:: CancelRepeat()
~*RButton:: CancelRepeat()
~*MButton:: CancelRepeat()
~*XButton1:: CancelRepeat()
~*XButton2:: CancelRepeat()

; Number keys
~*0:: CancelRepeat()
~*1:: CancelRepeat()
~*2:: CancelRepeat()
~*3:: CancelRepeat()
~*4:: CancelRepeat()
~*5:: CancelRepeat()
~*6:: CancelRepeat()
~*7:: CancelRepeat()
~*8:: CancelRepeat()
~*9:: CancelRepeat()

; F keys (F2-F24, F1 is already handled as a modifier)
~*F2:: CancelRepeat()
~*F3:: CancelRepeat()
~*F4:: CancelRepeat()
~*F5:: CancelRepeat()
~*F6:: CancelRepeat()
~*F7:: CancelRepeat()
~*F8:: CancelRepeat()
~*F9:: CancelRepeat()
~*F10:: CancelRepeat()
~*F11:: CancelRepeat()
~*F12:: CancelRepeat()
~*F13:: CancelRepeat()
~*F14:: CancelRepeat()
~*F15:: CancelRepeat()
~*F16:: CancelRepeat()
~*F17:: CancelRepeat()
~*F18:: CancelRepeat()
~*F19:: CancelRepeat()
~*F20:: CancelRepeat()
~*F21:: CancelRepeat()
~*F22:: CancelRepeat()
~*F23:: CancelRepeat()
~*F24:: CancelRepeat()

; Punctuation and symbol keys
~*,:: CancelRepeat()
~*.:: CancelRepeat()
~*/:: CancelRepeat()
~*`;:: CancelRepeat()
~*':: CancelRepeat()
~*[:: CancelRepeat()
~*]:: CancelRepeat()
~*\:: CancelRepeat()
~*-:: CancelRepeat()
~*=:: CancelRepeat()

; Navigation keys
~*Home:: CancelRepeat()
~*End:: CancelRepeat()
~*PgUp:: CancelRepeat()
~*PgDn:: CancelRepeat()
~*Up:: CancelRepeat()
~*Down:: CancelRepeat()
~*Left:: CancelRepeat()
~*Right:: CancelRepeat()
~*Delete:: CancelRepeat()
~*Pause:: CancelRepeat()
~*PrintScreen:: CancelRepeat()

CancelRepeat() {
    global autoRepeat, isWKey, currentKey
    if !autoRepeat
        return
    
    ; Special rules for W key - certain keys do NOT cancel it
    if (isWKey) {
        ; For W key, we need to check which key was pressed
        ; We'll use a different approach - check the A_ThisHotkey
        hotkeyPressed := A_ThisHotkey
        ; Remove the ~* prefix to get the clean key name
        hotkeyPressed := StrReplace(hotkeyPressed, "~*", "")
        
        ; These keys do NOT cancel W: a, d, e, f, w, Space, Tab, Shift, Ctrl, Alt, CapsLock, Esc, LButton, RButton, MButton, XButton1, XButton2
        forbiddenCancelKeys := ["a", "d", "e", "f", "w", "Space", "Tab", "Shift", "Ctrl", "Alt", "CapsLock", "Esc", "LButton", "RButton", "MButton", "XButton1", "XButton2"]
        
        ; Check if the pressed key is in the forbidden list
        keyFound := false
        for key in forbiddenCancelKeys {
            if (key = hotkeyPressed) {
                keyFound := true
                break
            }
        }
        
        ; If the key is NOT in the forbidden list, then cancel W
        if (!keyFound) {
            StopAutoRepeat()
        }
    } else {
        ; For all non-W keys, any key press cancels it
        StopAutoRepeat()
    }
}

StartAutoRepeat(key) {
    global autoRepeat, currentKey, isWKey, isShiftQ, refreshMs
    if autoRepeat
        StopAutoRepeat()
    
    autoRepeat := true
    currentKey := key
    isWKey := (key = "w")
    isShiftQ := false
    
    ; Special case for W key - also hold Shift for sprinting
    if (isWKey) {
        Send("{Shift down}")
        Send("{w down}")
    } else {
        ; For other keys, send initial press
        Send("{" . currentKey . " down}")
        Send("{" . currentKey . " up}")
    }
    SetTimer(HoldKeyRefresh, refreshMs)
}

StopAutoRepeat() {
    global autoRepeat, currentKey, isWKey, isShiftQ
    if !autoRepeat
        return
    
    autoRepeat := false
    isWKey := false
    isShiftQ := false
    
    SetTimer(HoldKeyRefresh, 0)
    if (currentKey != "") {
        if (currentKey = "w") {
            ; For W key, release both Shift and W
            Send("{w up}")
            if (!isShiftQ) {
                ; Only release Shift if it wasn't Shift + Q (Shift was already held)
                Send("{Shift up}")
            }
        } else {
            ; For other keys, just release the key
            Send("{" . currentKey . " up}")
        }
    }
    currentKey := ""
}