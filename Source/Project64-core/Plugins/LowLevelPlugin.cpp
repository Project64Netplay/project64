#include "stdafx.h"
#include <Project64-core/N64System/SystemGlobals.h>
#include <Project64-core/N64System/N64Rom.h>
#include <Project64-core/N64System/N64Disk.h>
#include <Project64-core/N64System/Mips/MemoryVirtualMem.h>
#include <Project64-core/N64System/Mips/Register.h>
#include <Project64-core/N64System/N64System.h>
#include "LowLevelPlugin.h"

uint8_t CLowLevel_Plugin::AddressMask[1024];

CLowLevel_Plugin::CLowLevel_Plugin(const stdstr& pluginDir)
    : pluginDir(pluginDir) {

}

CLowLevel_Plugin::~CLowLevel_Plugin() {
    if (dll) FreeLibrary(dll);
}

void CLowLevel_Plugin::Initialize() {
    if (dll) FreeLibrary(dll);
    dll = LoadLibraryA((pluginDir + "LowLevel\\" + g_Rom->GetRomName() + ".dll").c_str());
    OnRomOpen = dll ? (void(*)(HWND, const char*, const char*, void(*)(uint32_t), uint32_t*, MIPS_DWORD*, MIPS_DWORD*, uint8_t*, uint32_t))GetProcAddress(dll, "RomOpen") : NULL;
    OnRomClosed = dll ? (void(*)())GetProcAddress(dll, "RomClosed") : NULL;
    OnFrame = dll ? (void(*)(uint32_t*))GetProcAddress(dll, "FrameHandler") : NULL;
    OnExecute = dll ? (void(*)(uint32_t))GetProcAddress(dll, "ExecutionHandler") : NULL;
    OnRead8 = dll ? (void(*)(uint32_t, uint8_t*))GetProcAddress(dll, "ReadByteHandler") : NULL;
    OnRead16 = dll ? (void(*)(uint32_t, uint16_t*))GetProcAddress(dll, "ReadShortHandler") : NULL;
    OnRead32 = dll ? (void(*)(uint32_t, uint32_t*))GetProcAddress(dll, "ReadIntHandler") : NULL;
    OnRead64 = dll ? (void(*)(uint32_t, uint64_t*))GetProcAddress(dll, "ReadLongHandler") : NULL;
    OnWrite8 = dll ? (void(*)(uint32_t, uint8_t*))GetProcAddress(dll, "WriteByteHandler") : NULL;
    OnWrite16 = dll ? (void(*)(uint32_t, uint16_t*))GetProcAddress(dll, "WriteShortHandler") : NULL;
    OnWrite32 = dll ? (void(*)(uint32_t, uint32_t*))GetProcAddress(dll, "WriteIntHandler") : NULL;
    OnWrite64 = dll ? (void(*)(uint32_t, uint64_t*))GetProcAddress(dll, "WriteLongHandler") : NULL;
    ZeroMemory(AddressMask, sizeof AddressMask);
}

void CLowLevel_Plugin::RomOpened(RenderWindow* window) {
    Initialize();
    if (!OnRomOpen) return;
    OnRomOpen(
        (HWND)window->GetWindowHandle(),
        g_Rom->GetRomName().c_str(),
        g_Rom->GetRomMD5().c_str(),
        &AddAddress,
        &g_Reg->m_PROGRAM_COUNTER,
        g_Reg->m_GPR,
        g_Reg->m_FPR,
        g_MMU->Rdram(),
        g_MMU->RdramSize()
    );
}

void CLowLevel_Plugin::RomClose(RenderWindow* window) {
    if (OnRomClosed) OnRomClosed();
}
