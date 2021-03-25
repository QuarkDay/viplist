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
local directIni = "moonloader\\vlsettings.ini"
local mainIni = inicfg.load(nil, directIni)
local stateIni = inicfg.save(mainIni, directIni)
local key = require "vkeys"
local sampev = require 'samp.events'
local imgui = require 'imgui' 
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/QuarkDay/viplist/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = ""
local script_path = thisScript().path

local table1

local shablon = {
    config = {
		name = "",
		players = "",
		date = ""
}
}








local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local text_duffer = imgui.ImBuffer(256)
local text_suffer = imgui.ImBuffer(256)





function main()

	
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

 	downloadUrlToFile(update_url, update_path, function (id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then 
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage("Есть обнова", -1)
			end
		end
	end)

	imgui.Process = false

	
	sampRegisterChatCommand("addvips", cmd_imgui)
	sampRegisterChatCommand("vipl", listoc)
	sampRegisterChatCommand("vlinfo", vlinfo)

	Dialog = lua_thread.create_suspended(RandomFunc)

	sampAddChatMessage("PASHOL NAHUY", 0xFFFFFF)
	
	table1 = inicfg.load(nil, directIni) 


    if table1 == nil then
        inicfg.save(shablon, directIni)
        table1 = inicfg.load(nil, directIni)
    end
	
	while true do
		wait(0)
		if main_window_state.v == false then
		imgui.Process = false

		if update_state then
			downloadUrlToFile(update_url, script_path, function (id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then 
					sampAddChatMessage("Скрипт обновлён, додек", -1)
				 	thisScript():reload()
				end
			end)
			break
		end

	end
	end
	
end

function vlinfo()
	sampShowDialog(1, "{00ffff}Описание скрипта", "{FFFFFF}VipList - это скрипт для репортёров, позволяющий посмотреть текущие {DC143C}VIP Фракции и Игроков {FFFFFF}, не выходя из игры и\nне заглядывая на форум.\n\n{00FFFF}Команды:\n{00FF00}/addvips {FFFFFF}- открывает окно, в котором можно вписать текущих {DC143C}VIP Персон{FFFFFF}.\n{00FF00}/vipl {FFFFFF} - показывает список текущих {DC143C}VIP Персон{FFFFFF}.\n\n{00FFFF}Примечение{FFFFFF}: данный скрипт создан на дичайших \"костылях\", а потому в нём присутствуют следующие неудобства:\n{FFFFFF}Если вы нажмёте на кнопку \"{DC143C}Сохранить{FFFFFF}\", но ничего не впишете в поля\nдля ввода и {DC143C}перезапустите скрипт{FFFFFF}, то список {DC143C}слетит{FFFFFF} и придётся составлять его {DC143C}заново{FFFFFF}.\nТакже, каждый раз, как вам придётся обновить список, его придётся составлять {DC143C}с нуля{FFFFFF}, т.к. информация в полях\nдля ввода не остаётся там навечно.\n\n{00FFFF}Для всех любителей писать скрипты{FFFFFF}:\nЕсли вы вдруг захотите как-либо улучшить/изменить скрипт и/или исправить его недостатки, то\nвы сможете спокойно это сделать, т.к. исходный код скрипта я оставляю открытым.", "Закрыть", "", 0)
end

function imgui.OnDrawFrame()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(900, 600), imgui.Cond.FirstUseEver)
  imgui.Begin(u8'Составление VIP списка', main_window_state) 
  
        imgui.Text(u8'Введите VIP Фракции')
        imgui.SameLine()
        imgui.InputText('', text_buffer)

        imgui.Text(u8'Введите VIP Игроков')
        imgui.SameLine()
        imgui.InputText(' ', text_duffer)

        imgui.Text(u8'Введите дату списка')
        imgui.SameLine()
        imgui.InputText('  ', text_suffer)
		

	if imgui.Button(u8"Сохранить") then
    mainIni.config.name = u8:decode(text_buffer.v)
	mainIni.config.players = u8:decode(text_duffer.v)
	mainIni.config.date = u8:decode(text_suffer.v)
    inicfg.save(mainIni, directIni)
	sampAddChatMessage("{FFFFFF}Успешно сохранено!", -1)
end

  
	
  
  imgui.End() 
end

function cmd_imgui(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function listoc(arg)
	sampAddChatMessage("{12FFE7}Список VIP фракций:", -1)
	lua_thread.create(function()
	wait(0)
	sampAddChatMessage(mainIni.config.name, -1)
	wait(0)
	sampAddChatMessage("{12FFE7}Список VIP игроков:", -1)
	wait(0)
	sampAddChatMessage(mainIni.config.players, -1)
	wait(0)
	sampAddChatMessage("{12FFE7}Список был составлен:", -1)
	wait(0)
	sampAddChatMessage(mainIni.config.date, -1)
	end)
end

