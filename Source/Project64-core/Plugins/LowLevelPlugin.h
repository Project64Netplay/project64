#pragma once

#include <Project64-core/Plugins/PluginBase.h>
#include <Project64-core/N64System/SystemGlobals.h>
#include <Project64-core/N64System/N64Rom.h>

class CLowLevel_Plugin {
public:
    static uint8_t AddressMask[1024];

    stdstr pluginDir;
    HMODULE dll = NULL;
    void(*OnRomOpen)(HWND, const char*, const char*, void(*)(uint32_t), uint32_t*, MIPS_DWORD*, MIPS_DWORD*, uint8_t*, uint32_t) = NULL;
    void(*OnRomClosed)() = NULL;
    void(*OnFrame)(uint32_t*) = NULL;
    void(*OnExecute)(uint32_t) = NULL;
    void(*OnRead8)(uint32_t, uint8_t*) = NULL;
    void(*OnRead16)(uint32_t, uint16_t*) = NULL;
    void(*OnRead32)(uint32_t, uint32_t*) = NULL;
    void(*OnRead64)(uint32_t, uint64_t*) = NULL;
    void(*OnWrite8)(uint32_t, uint8_t*) = NULL;
    void(*OnWrite16)(uint32_t, uint16_t*) = NULL;
    void(*OnWrite32)(uint32_t, uint32_t*) = NULL;
    void(*OnWrite64)(uint32_t, uint64_t*) = NULL;

    CLowLevel_Plugin(const stdstr& pluginDir);
    ~CLowLevel_Plugin();
    void Initialize();
    void RomOpened(RenderWindow* window);
    void RomClose(RenderWindow* window);

    static inline int IsAddressMasked(uint32_t address) {
        address /= 4;
        return AddressMask[(address / 8) % sizeof AddressMask] & (1 << (address % 8));
    }

    static void AddAddress(uint32_t address) {
        address /= 4;
        AddressMask[(address / 8) % sizeof AddressMask] |= (1 << (address % 8));
    }
};