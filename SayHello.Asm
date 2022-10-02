.686
.MMX
.XMM
.model flat,stdcall
option casemap:none

Include x64dbgpluginsdk.inc 
Include SayHello.inc 

.CONST
PLUGIN_VERSION      EQU 1

.DATA
PLUGIN_NAME         DB 	"Say Hello",0
text				db	"Hello from x64dbg!",0
caption				db	"info",0

.DATA?

PUBLIC              pluginHandle
PUBLIC              hMenu

hMenu               DD 	?
pluginHandle        DD 	?
hWndx64dbg			DD	?
.CODE


DllMain PROC hinstDLL:HINSTANCE, fdwReason:DWORD, lpvReserved:DWORD
    .IF fdwReason == DLL_PROCESS_ATTACH
        mov eax, hinstDLL
        mov hInstance, eax
        
    .ENDIF
    mov eax,TRUE
    ret
DllMain ENDP

pluginit PROC C PUBLIC USES EBX initStruct:DWORD
    mov ebx, initStruct
    mov eax, PLUGIN_VERSION
    mov [ebx].PLUG_INITSTRUCT.pluginVersion, eax
    mov eax, PLUG_SDKVERSION
    mov [ebx].PLUG_INITSTRUCT.sdkVersion, eax
    Invoke lstrcpy, Addr [ebx].PLUG_INITSTRUCT.pluginName, Addr PLUGIN_NAME
    mov ebx, initStruct
    mov eax, [ebx].PLUG_INITSTRUCT.pluginHandle
    mov pluginHandle, eax
	mov eax, TRUE
	ret
pluginit ENDP

plugstop PROC C PUBLIC 
    Invoke _plugin_menuclear, hMenu
    mov eax, TRUE
    ret
plugstop ENDP

plugsetup PROC C PUBLIC USES EBX setupStruct:DWORD
    mov ebx, setupStruct
    mov eax, [ebx].PLUG_SETUPSTRUCT.hMenu
    mov hMenu, eax
   ; Invoke _plugin_menuaddentry, hMenu, MENU_Hellox64dbg, Addr szHellox64dbg
    ret
plugsetup ENDP

CBMENUENTRY PROC C PUBLIC USES EBX cbType:DWORD, cbInfo:DWORD
    mov ebx, cbInfo
    mov eax, [ebx].PLUG_CB_MENUENTRY.hEntry
    .IF eax == MENU_Hellox64dbg
   		invoke	MessageBox,0,addr text,addr caption,MB_ICONINFORMATION
    .ENDIF
    
    ret

CBMENUENTRY ENDP

END DllMain
















