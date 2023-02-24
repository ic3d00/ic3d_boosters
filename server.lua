
ESX = exports["es_extended"]:getSharedObject()

--[[ MAKE A RETURN WITH TRIGGER EVENT (EASIER BOOST CHECKS)
loot2x 12
loot3x 13

skill2x 22
skill3x 23

xp2x 32
xp3x 33

full2x 42
full3x 43
--]]


--EXAMPLE

RegisterCommand("boostloot2x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostloot = 12 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM LOOT2X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)

--]]


RegisterCommand("boostloot2x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostloot = 12 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM LOOT2X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)
RegisterCommand("boostloot3x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostloot = 13 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM LOOT3X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)


RegisterCommand("boostxp2x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostxp = 32 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM XP2X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)
RegisterCommand("boostxp3x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostxp = 33 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM XP3X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)






RegisterCommand("boostskills2x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostskills = 22 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM SKILLS2X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)
RegisterCommand("boostskills3x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostxp = 23 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM SKILLS3X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)












RegisterCommand("boostfull2x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostfull = 42 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM FULL2X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)
RegisterCommand("boostfull3x", function(source, args, rawCommand)
  local identifier = args[1]

  -- update is_vip column in database for player
  MySQL.Async.execute("UPDATE users SET boostfull = 43 WHERE identifier = @identifier", {
    ["@identifier"] = identifier
  }, function(rowsChanged)
    if rowsChanged > 0 then
     
      print("PLAYER"..identifier.." COM FULL3X!")
 
    else
     
      print("Nenhum identifier encontrado")
    
    end
  end)
end, true)






RegisterServerEvent("tp-advancedzombies:onZombiesLootReward")
AddEventHandler("tp-advancedzombies:onZombiesLootReward", function(entityName)
    local _source = source
    entityName = string.lower(entityName)

    local entityRewardLevel = Config.ZombiePedModelsData[entityName].loot
    local rewardData = Config.Zombies.Loot.LootRewardPackages[entityRewardLevel]
    
    if entityRewardLevel and rewardData then
        if Config.Framework == "ESX" then
            local xPlayer    = ESX.GetPlayerFromId(_source)
			local identifier = xPlayer.getIdentifier()
			local hasBoost = MySQL.Sync.fetchScalar("SELECT boostloot FROM users WHERE identifier = @identifier", {["@identifier"] = identifier})
			local hasBoostFull = MySQL.Sync.fetchScalar("SELECT boostfull FROM users WHERE identifier = @identifier", {["@identifier"] = identifier})
    
            if rewardData.account.cash and rewardData.account.cash > 0 then
                xPlayer.addMoney(rewardData.account.cash)
            end
    
            if rewardData.account.black_money and rewardData.account.black_money > 0 then
                xPlayer.addAccountMoney("black_money", rewardData.account.black_money)
            end
    
            if rewardData.items then
    
                for k, v in pairs (rewardData.items) do
    
                    local randomChance = math.random(0, 100)
    
                    if randomChance <= v.chance then
    
                        if v.randomAmount then
    local randomAmount = math.random(v.min, v.max)
    if randomAmount > 0 then
        xPlayer.addInventoryItem(k, randomAmount)
		print("loot1x")
        -- Give extra item to VIP player
        if hasBoost == 12 and not hasBoostFull == 42 and not hasBoostFull == 43 then
            xPlayer.addInventoryItem(k, randomAmount)
			print("loot2x")
        end
		if hasBoost == 13 and not hasBoostFull == 42 and not hasBoostFull == 43 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("loot3x")
        end
		if hasBoostFull == 42 and not hasBoost == 12 and not hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
			print("full2x")
        end
		if hasBoostFull == 43 and not hasBoost == 12 and not hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full3x")
        end
		if hasBoostFull == 42 and hasBoost == 12 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full2x & loot2x")
        end
		if hasBoostFull == 42 and hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full2x & loot3x")
        end
		if hasBoostFull == 43 and hasBoost == 12 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full3x & loot2x")
        end
		if hasBoostFull == 43 and hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full3x & loot3x")
        end
    end
else
    if v.max > 0 then
        xPlayer.addInventoryItem(k, v.max)
		print("loot1x")
        -- Give extra item to VIP player
        if hasBoost == 12 and not hasBoostFull == 42 and not hasBoostFull == 43 then
            xPlayer.addInventoryItem(k, randomAmount)
			print("loot2x")
        end
		if hasBoost == 13 and not hasBoostFull == 42 and not hasBoostFull == 43 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("loot3x")
        end
		if hasBoostFull == 42 and not hasBoost == 12 and not hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
			print("full2x")
        end
		if hasBoostFull == 43 and not hasBoost == 12 and not hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full3x")
        end
		if hasBoostFull == 42 and hasBoost == 12 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full2x & loot2x")
        end
		if hasBoostFull == 42 and hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full2x & loot3x")
        end
		if hasBoostFull == 43 and hasBoost == 12 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full3x & loot2x")
        end
		if hasBoostFull == 43 and hasBoost == 13 then
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
            xPlayer.addInventoryItem(k, randomAmount)
			print("full3x & loot3x")
        end
    end
end
    
                    end
    
                end
            end
    
            if rewardData.weapons then
    
                for k, v in pairs (rewardData.weapons) do

                    local randomChance = math.random(0, 100)
    
                    if randomChance <= v.chance then
        
                        if v.randomAmount then
                            local randomAmount = math.random(v.min, v.max)
        
                            if randomAmount <= 0 then
                                xPlayer.addWeapon(k, 1)
                            else
                                xPlayer.addWeapon(k, randomAmount)
                            end
        
                        else
                            if v.max <= 0 then
                                xPlayer.addInventoryItem(k, 1)
                            else
                                xPlayer.addInventoryItem(k, v.max)
                            end
                        end
        
                    end
                end
    
            end
    
    
        elseif Config.Framework == "QBCore" then
            local xPlayer    = QBCore.Functions.GetPlayer(_source)
            
            if rewardData.account.cash and rewardData.account.cash > 0 then
                xPlayer.Functions.AddMoney('cash', rewardData.account.cash)
            end
    
            if rewardData.account.black_money and rewardData.account.black_money > 0 then
                xPlayer.Functions.AddMoney('black_money', rewardData.account.black_money)
            end
            
            if rewardData.items then
    
                for k, v in pairs (rewardData.items) do
    
                    local randomChance = math.random(0, 100)
    
                    if randomChance <= v.chance then
    
                        if v.randomAmount then
                            local randomAmount = math.random(v.min, v.max)
        
                            if randomAmount > 0 then
                                xPlayer.Functions.AddItem(k, randomAmount)
                            end
                        else
                            if v.max > 0 then
                                xPlayer.Functions.AddItem(k, v.max)
                            end
                        end
    
                    end
    
                end
    
            end
    
            if rewardData.weapons then
    
                for k, v in pairs (rewardData.weapons) do
                    local randomChance = math.random(0, 100)
    
                    if randomChance <= v.chance then
        
                        if v.randomAmount then
                            local randomAmount = math.random(v.min, v.max)
        
                            if randomAmount <= 0 then
                                xPlayer.Functions.AddItem(k, 1)
                            else
                                xPlayer.Functions.AddItem(k, randomAmount)
                            end
        
                        else
                            if v.max <= 0 then
                                xPlayer.Functions.AddItem(k, 1)
                            else
                                xPlayer.Functions.AddItem(k, v.max)
                            end
                        end
        
                    end
                end
    
            end
    
        end
    else
        print("The specified zombie {" .. entityName .. "} does not have any loot data in Config.ZombiePedModelsData or the loot package does not exist.")
    end

end)

