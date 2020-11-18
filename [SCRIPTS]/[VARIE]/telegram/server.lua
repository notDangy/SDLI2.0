local redemrp = false

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("Telegram:GetMessages")
AddEventHandler("Telegram:GetMessages", function(src)
	local _source
	
	if not src then 
		_source = source
	else 
		_source = src
	end

	if redemrp then 
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
			local recipient = Character.getIdentifier()
			local recipientid = Character.getSessionVar("charid")
			
			MySQL.Async.fetchAll("SELECT * FROM telegrams WHERE recipient=@recipient AND recipientid=@recipientid ORDER BY id DESC", { ['@recipient'] = recipient, ['@recipientid'] = recipientid }, function(result)
				TriggerClientEvent("Telegram:ReturnMessages", _source, result)
			end)
		end)
	else 
		local User = VorpCore.getUser(_source) 
		local Character = User.getUsedCharacter 			
		local recipient = Character.identifier
			
		exports.ghmattimysql:execute("SELECT * FROM telegrams WHERE recipient=@recipient ORDER BY id DESC", { ['@recipient'] = recipient }, function(result)
			TriggerClientEvent("Telegram:ReturnMessages", _source, result)
		end)
	end
end)

RegisterServerEvent("Telegram:SendMessage")
AddEventHandler("Telegram:SendMessage", function(firstname, lastname, message, players)
	local _source = source

	if redemrp then 
		TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
			local sender = Character.getName()

			-- get the steam and character id of the recipient
			MySQL.Async.fetchAll("SELECT identifier, characterid FROM characters WHERE firstname=@firstname AND lastname=@lastname", { ['@firstname'] = firstname, ['@lastname'] = lastname}, function(result)
				if result[1] then 
					local recipient = result[1].identifier 
					local recipientid = result[1].characterid

					local paramaters = { ['@sender'] = sender, ['@recipient'] = recipient, ['@recipientid'] = recipientid, ['@message'] = message }

					MySQL.Async.execute("INSERT INTO telegrams (sender, recipient, recipientid, message) VALUES (@sender, @recipient, @recipientid, @message)",  paramaters, function(count)
						if count > 0 then 
							for k, v in pairs(players) do
								TriggerEvent('redemrp:getPlayerFromId', v, function(user)
									if Character.getName() == firstname .. " " .. lastname then 
									--	TriggerClientEvent("redemrp_notification:start", _source, "You've received a telegram.", 3)
										TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Telegramma", "Hai ricevuto un telegramma.", "generic_textures", "tick", 3000)
									--	TriggerClientEvent("vorp:Tip", _source, "Hai ricevuto un nuovo telegramma.", 3000)
									end
								end)
							end
						else 
							TriggerClientEvent("redemrp_notification:start", _source, "We're unable to process your Telegram right now. Please try again later.", 3)
						end
					end)

					TriggerClientEvent("redemrp_notification:start", _source, "Your telegram has been posted", 3)
				else 
					TriggerClientEvent("redemrp_notification:start", _source, "Unable to process Telegram. Invalid first or lastname.", 3)
				end
			end)
		end)
	else 
		local User = VorpCore.getUser(_source) 
		local Character = User.getUsedCharacter 			
		local sender = Character.firstname .. " " .. Character.lastname

		exports.ghmattimysql:execute("SELECT identifier FROM characters WHERE firstname=@firstname AND lastname=@lastname", { ['@firstname'] = firstname, ['@lastname'] = lastname}, function(result)
			if result[1] then 
				local recipient = result[1].identifier 

				local paramaters = { ['@sender'] = sender, ['@recipient'] = recipient, ['@recipientid'] = 1, ['@message'] = message }

				exports.ghmattimysql:execute("INSERT INTO telegrams (sender, recipient, recipientid, message) VALUES (@sender, @recipient, @recipientid, @message)",  paramaters, function()
					for k, v in pairs(players) do
						local User = VorpCore.getUser(v) 
						local Character = User.getUsedCharacter 							
						local receiver = Character.firstname .. " " ..Character.lastname

						if receiver == firstname .. " " .. lastname then 
							--TriggerClientEvent("vorp:Tip", v, "Hai ricevuto un telegramma.", 3000)
							--TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Telegramma", "Hai ricevuto un telegramma.", "generic_textures", "tick", 3000)
							TriggerClientEvent("vorp:NotifyLeft", tonumber(v), "~t6~Telegramma", "Hai ricevuto un telegramma.", "generic_textures", "tick", 3000)
						end
					end
				end)
				--TriggerClientEvent("vorp:Tip", _source, "Il tuo telegramma è stato inviato!", 3000)
				TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Telegramma", "Il tuo telegramma è stato inviato!", "generic_textures", "tick", 3000)
			else 
			--	TriggerClientEvent("vorp:Tip", _source, "Impossibile inviare il telegramma. Nome o cognome errati", 3000)
				TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Impossibile inviare il telegramma. Nome o cognome errati", "menu_textures", "cross", 3000)
			end
			
		end)
	end
end)

RegisterServerEvent("Telegram:DeleteMessage")
AddEventHandler("Telegram:DeleteMessage", function(id)
	local _source = source

	if redemrp then 
		MySQL.Async.execute("DELETE FROM telegrams WHERE id=@id",  { ['@id'] = id }, function(count)
			if count > 0 then 
				TriggerEvent("Telegram:GetMessages", _source)
			else
				--TriggerClientEvent("redemrp_notification:start", _source, "Impossibile eliminare il telegramma. Riprova piu tardi", 3)
			--	TriggerClientEvent(source, "vorp:Tip", "Impossibile eliminare il telegramma. Riprova piu tardi", 3000)
			TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Impossibile inviare il telegramma. Nome o cognome errati", "menu_textures", "cross", 3000)
			end
		end)
	else 
		exports.ghmattimysql:execute("DELETE FROM telegrams WHERE id=@id",  { ['@id'] = id }, function()
			TriggerEvent("Telegram:GetMessages", _source)
		end)
	end
end)
