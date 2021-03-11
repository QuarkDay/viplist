script_name("VIP List")
script_authors("KOFFEMOLKA")
script_description("Список VIP игроков")
script_version("1.0")
script_dependencies("CLEO")

---------------------------------------------------------------------------
local hook = require 'lib.samp.events'
require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.defaul = 'CP1251'
u8 = encoding.UTF8

update_state = false

local script_verse = 1
local script_verse_text = "1.00"

local update_url = "https://raw.githubusercontent.com/QuarkDay/viplist/main/update.ini"
local pdate_path = getWorkingDirectory().. "/update.ini"

local script_url = ""
local script_path = thisScript().path
 

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	
	sampRegisterChatCommand("vipl", cmd_update)

	sampAddChatMessage(("{00FA9A}VIP List Test v"..thisScript().version..'{FFD700} |{FFFFFF}Активация: {10bfeb}/vipl{FFD700}|{FFFFFF} Автор: {00FA9A}KOFFEMOLKA'), 0xFFFFFF)
	
	

    
	
	

end

function cmd_update(arg)
 sampShowDialog(1000, "Ага", "{FFFFFF}Ага\nЕжжи", "Закрыть", "", 0)
end

function vipcheck()
    sampAddChatMessage("{12FFE7}Список VIP фракций:", -1)
    lua_thread.create(function()
        wait(0)
        sampAddChatMessage("{3399FF}Los Aztecas {FFFFFF}(до 17.03.21){FFFFFF}; {FF19FF}TTM {FFFFFF}(до 25.05.21); {604282}Black Kings {FFFFFF}(до 16.03.21)", -1)
		wait(0)
        sampAddChatMessage("{B69CFF}LVPD{FFFFFF}; {2A8000}Армия{FFFFFF}; {800000}МЧС{FFFFFF}; {FFA95E}Коллегия Адвокатов", -1)
		wait(0)
        sampAddChatMessage("{12FFE7}Список VIP игроков:", -1)
		wait(0)
        sampAddChatMessage("{FFFFFF}Весь МД состав со 2LvL; SOLOVEY (до 28.03.21)", -1)
    end)
end
