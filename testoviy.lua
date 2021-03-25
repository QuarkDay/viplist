script_name("VIP List")
script_authors("KOFFEMOLKA")
script_description("������ VIP �������")
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
				sampAddChatMessage("���� ������", -1)
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
					sampAddChatMessage("������ �������, �����", -1)
				 	thisScript():reload()
				end
			end)
			break
		end

	end
	end
	
end

function vlinfo()
	sampShowDialog(1, "{00ffff}�������� �������", "{FFFFFF}VipList - ��� ������ ��� ���������, ����������� ���������� ������� {DC143C}VIP ������� � ������� {FFFFFF}, �� ������ �� ���� �\n�� ���������� �� �����.\n\n{00FFFF}�������:\n{00FF00}/addvips {FFFFFF}- ��������� ����, � ������� ����� ������� ������� {DC143C}VIP ������{FFFFFF}.\n{00FF00}/vipl {FFFFFF} - ���������� ������ ������� {DC143C}VIP ������{FFFFFF}.\n\n{00FFFF}����������{FFFFFF}: ������ ������ ������ �� �������� \"��������\", � ������ � �� ������������ ��������� ����������:\n{FFFFFF}���� �� ������ �� ������ \"{DC143C}���������{FFFFFF}\", �� ������ �� ������� � ����\n��� ����� � {DC143C}������������� ������{FFFFFF}, �� ������ {DC143C}������{FFFFFF} � ������� ���������� ��� {DC143C}������{FFFFFF}.\n�����, ������ ���, ��� ��� ������� �������� ������, ��� ������� ���������� {DC143C}� ����{FFFFFF}, �.�. ���������� � �����\n��� ����� �� ������� ��� �������.\n\n{00FFFF}��� ���� ��������� ������ �������{FFFFFF}:\n���� �� ����� �������� ���-���� ��������/�������� ������ �/��� ��������� ��� ����������, ��\n�� ������� �������� ��� �������, �.�. �������� ��� ������� � �������� ��������.", "�������", "", 0)
end

function imgui.OnDrawFrame()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(900, 600), imgui.Cond.FirstUseEver)
  imgui.Begin(u8'����������� VIP ������', main_window_state) 
  
        imgui.Text(u8'������� VIP �������')
        imgui.SameLine()
        imgui.InputText('', text_buffer)

        imgui.Text(u8'������� VIP �������')
        imgui.SameLine()
        imgui.InputText(' ', text_duffer)

        imgui.Text(u8'������� ���� ������')
        imgui.SameLine()
        imgui.InputText('  ', text_suffer)
		

	if imgui.Button(u8"���������") then
    mainIni.config.name = u8:decode(text_buffer.v)
	mainIni.config.players = u8:decode(text_duffer.v)
	mainIni.config.date = u8:decode(text_suffer.v)
    inicfg.save(mainIni, directIni)
	sampAddChatMessage("{FFFFFF}������� ���������!", -1)
end

  
	
  
  imgui.End() 
end

function cmd_imgui(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function listoc(arg)
	sampAddChatMessage("{12FFE7}������ VIP �������:", -1)
	lua_thread.create(function()
	wait(0)
	sampAddChatMessage(mainIni.config.name, -1)
	wait(0)
	sampAddChatMessage("{12FFE7}������ VIP �������:", -1)
	wait(0)
	sampAddChatMessage(mainIni.config.players, -1)
	wait(0)
	sampAddChatMessage("{12FFE7}������ ��� ���������:", -1)
	wait(0)
	sampAddChatMessage(mainIni.config.date, -1)
	end)
end

