-- Senglar
local teclas = {["A"] = 0x7065027D,["B"] = 0x4CC0E2FE,["C"] = 0x9959A6F0,["D"] = 0xB4E465B4,["E"] = 0xCEFD9220,["F"] = 0xB2F377E8,["G"] = 0x760A9C6F,["H"] = 0x24978A28,["I"] = 0xC1989F95,["J"] = 0xF3830D8E,["L"] = 0x80F28E95,["M"] = 0xE31C6A41,["N"] = 0x4BC9DABB,["O"] = 0xF1301666,["P"] = 0xD82E0BD2,["Q"] = 0xDE794E3E,["R"] = 0xE30CD707,["S"] = 0xD27782E3,["U"] = 0xD8F73058,["V"] = 0x7F8D09B8,["W"] = 0x8FD015D8,["X"] = 0x8CC9CD42,["Z"] = 0x26E9DC00,["RIGHTBRACKET"] = 0xA5BDCD3C,["LEFTBRACKET"] = 0x430593AA,["MOUSE1"] = 0x07CE1E61,["MOUSE2"] = 0xF84FA74F,["MOUSE3"] = 0xCEE12B50,["MWUP"] = 0x3076E97C,["CTRL"] = 0xDB096B85,["TAB"] = 0xB238FE0B,["SHIFT"] = 0x8FFC75D6,["SPACEBAR"] = 0xD9D0E1C0,["ENTER"] = 0xC7B5340A,["BACKSPACE"] = 0x156F7119,["LALT"] = 0x8AAA0AD4,["DEL"] = 0x4AF4D473,["PGUP"] = 0x446258B6,["PGDN"] = 0x3C3DD371,["F1"] = 0xA8E3F467,["F4"] = 0x1F6D95E5,["F6"] = 0x3C0A40F2,["1"] = 0xE6F612E4,["2"] = 0x1CE6D9EB,["3"] = 0x4F49CC4C,["4"] = 0x8F9F9E58,["5"] = 0xAB62E997,["6"] = 0xA1FDE2A6,["7"] = 0xB03A913B,["8"] = 0x42385422,["DOWN"] = 0x05CA7C52,["UP"] = 0x6319DB71,["LEFT"] = 0xA65EBAB4,["RIGHT"] = 0xDEB34313,}
local puesta = false

RegisterNetEvent("menu:bandana:toggle")
AddEventHandler("menu:bandana:toggle", function()
	if puesta then 
		Citizen.InvokeNative(0xAE72E7DF013AAA61,PlayerPedId(),GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_OFF_RIGHT_HAND"), 1, 0, -1082130432)
		Wait(700)
		-- Quitar bandana
		Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(),-972364774)
		Citizen.InvokeNative(0xCC8CA3E88256E58F,PlayerPedId(),0,1,1,1,false)
		puesta = false
	else
		Citizen.InvokeNative(0xAE72E7DF013AAA61,PlayerPedId(),GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_ON_RIGHT_HAND"), 1, 0, -1082130432)
		Wait(700)
		-- Poner bandana
		Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(),-1100875244)
		Citizen.InvokeNative(0xCC8CA3E88256E58F,PlayerPedId(),0,1,1,1,false)
		puesta = true
	end
end)

-- Algunos otros que encontré
-- Some other i found

-- bolsa verdugo clara // Bag in the head
-- Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(), 1606325429)
-- bolsa verdugo mas obscura // idem
-- Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(), 1743550585)
-- bolsa verdugo mas clara // idem
-- Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(), 1064646155)
-- mascara de hueso // bone mask
-- Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(), -536694793)
-- otra mascara
-- Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(), -1304053509)
