-- Shootable Boxes v1.0 (c) 2023 Zibon "PixL" Badi
-- This add-on is licensed under the GNU Affero GPLv3
-- <https://www.gnu.org/licenses/agpl-3.0.en.html>

-- Blurt out legal stuff
CONS_Printf(players[0], "\x83===================================================\n" ..
"Shootable Boxes v1.0 (c) 2023 Zibon \"PixL\" Badi\n" ..
"This add-on is licensed under the GNU Affero GPLv3\n" ..
"<https://www.gnu.org/licenses/agpl-3.0.en.html>\n" ..
"===================================================\n" ..
"\x84\nType \x82sbhelp\x84 to get started.\x80"
)

local function sbhelp(player, command)
	if command == nil or command == "help" then
		local sb_val = CV_FindVar("sb_enable")
		CONS_Printf(player, "\n\82" ..
		"\x83===================================================\n" ..
		"Shootable Boxes v1.0 (c) 2023 Zibon \"PixL\" Badi\n" ..
		"This add-on is licensed under the GNU Affero GPLv3\n" ..
		"<https://www.gnu.org/licenses/agpl-3.0.en.html>\n" ..
		"===================================================\n" ..
		"\n" ..
		"\x8AVariables guide\n" ..
		"---------------\n\n" ..
		"\t\x82sb_help\x80\tPrint this help text.\n" ..
		"\t\x82sb_* (without suffix)\x80\tToggle weapons.\n" ..
		"\t\x82sb_*box_gold\x80\tToggle boxes by type.\n" ..
		"\t\x82sb_crossteam\x80\tShoot enemy boxes (CTF).\n" ..
		"\n" ..
		"Shootable Boxes (\x82cb_enable\x85) is \x85"+sb_val.string+"\x80.\n"
		)
	-- elseif command = then
	end
end


-- This script should be fine running server-side
local function shootableBoxes_live(target, inflictor, source, damage, damagetype)
	-- Is "shootableboxes" enabled?
	local sb_on = CV_FindVar("sb_enable")
	if sb_on.value == 0 or source.type != MT_PLAYER then
		return nil
	end
	-- Check for inflictor mobjtype.
	local sb_redrail = CV_FindVar("sb_redrail").value
	local sb_bounce = CV_FindVar("sb_bounce").value
	local sb_infinity = CV_FindVar("sb_infinity").value
	local sb_auto = CV_FindVar("sb_auto").value
	local sb_scatter = CV_FindVar("sb_scatter").value
	local sb_bomb = CV_FindVar("sb_bomb").value
	local sb_grenade = CV_FindVar("sb_grenade").value

	if 
		( sb_redrail and inflictor.type == MT_REDRING ) or
		( sb_bounce and inflictor.type == MT_THROWNBOUNCE ) or
		( sb_infinity and inflictor.type == MT_THROWNINFINITY ) or
		( sb_auto and inflictor.type == MT_THROWNAUTOMATIC ) or
		( sb_scatter and inflictor.type == MT_THROWNSCATTER ) or
		( sb_bomb and inflictor.type == MT_THROWNEXPLOSION ) or
		( sb_grenade and inflictor.type == MT_THROWNGRENADE )
	then
		-- Set monitor flags
		local sb_ringbox = CV_FindVar("sb_ringbox").value
		local sb_pitybox = CV_FindVar("sb_pitybox").value
		local sb_attractbox = CV_FindVar("sb_attractbox").value
		local sb_forcebox = CV_FindVar("sb_forcebox").value
		local sb_armageddonbox = CV_FindVar("sb_armageddonbox").value
		local sb_whirlwindbox = CV_FindVar("sb_whirlwindbox").value
		local sb_elementalbox = CV_FindVar("sb_elementalbox").value
		local sb_sneakersbox = CV_FindVar("sb_sneakersbox").value
		local sb_invulnbox = CV_FindVar("sb_invulnbox").value
		local sb_1upbox = CV_FindVar("sb_1upbox").value
		local sb_eggmanbox = CV_FindVar("sb_eggmanbox").value
		local sb_mixupbox = CV_FindVar("sb_mixupbox").value
		local sb_mysterybox = CV_FindVar("sb_mysterybox").value
		local sb_gravitybox = CV_FindVar("sb_gravitybox").value
		local sb_recyclerbox = CV_FindVar("sb_recyclerbox").value
		local sb_score1kbox = CV_FindVar("sb_score1kbox").value
		local sb_score10kbox = CV_FindVar("sb_score10kbox").value
		local sb_flameaurabox = CV_FindVar("sb_flameaurabox").value
		local sb_bubblewrapbox = CV_FindVar("sb_bubblewrapbox").value
		local sb_thundercoinbox = CV_FindVar("sb_thundercoinbox").value
		-- Goldboxes
		local sb_pitybox_gold = CV_FindVar("sb_pitybox_gold").value
		local sb_attractbox_gold = CV_FindVar("sb_attractbox_gold").value
		local sb_forcebox_gold = CV_FindVar("sb_forcebox_gold").value
		local sb_armageddonbox_gold = CV_FindVar("sb_armageddonbox_gold").value
		local sb_whirlwindbox_gold = CV_FindVar("sb_whirlwindbox_gold").value
		local sb_elementalbox_gold = CV_FindVar("sb_elementalbox_gold").value
		local sb_sneakersbox_gold = CV_FindVar("sb_sneakersbox_gold").value
		local sb_invulnbox_gold = CV_FindVar("sb_invulnbox_gold").value
		local sb_eggmanbox_gold = CV_FindVar("sb_eggmanbox_gold").value
		local sb_gravitybox_gold = CV_FindVar("sb_gravitybox_gold").value
		local sb_flameaurabox_gold = CV_FindVar("sb_flameaurabox_gold").value
		local sb_bubblewrapbox_gold = CV_FindVar("sb_bubblewrapbox_gold").value
		local sb_thundercoinbox_gold = CV_FindVar("sb_thundercoinbox_gold").value
		local sb_teamring = CV_FindVar("sb_teamring").value
		local sb_crossteam = CV_FindVar("sb_crossteam").value
		if (
			-- Monitor flags
			( sb_ringbox and target.type == MT_RING_BOX ) or
			( sb_pitybox and target.type == MT_PITY_BOX ) or
			( sb_attractbox and target.type == MT_ATTRACT_BOX ) or
			( sb_forcebox and target.type == MT_FORCE_BOX ) or
			( sb_armageddonbox and target.type == MT_ARMAGEDDON_BOX ) or
			( sb_whirlwindbox and target.type == MT_WHIRLWIND_BOX ) or
			( sb_elementalbox and target.type == MT_ELEMENTAL_BOX ) or
			( sb_sneakersbox and target.type == MT_SNEAKERS_BOX ) or
			( sb_invulnbox and target.type == MT_INVULN_BOX ) or
			( sb_1upbox and target.type == MT_1UP_BOX ) or
			( sb_eggmanbox and target.type == MT_EGGMAN_BOX ) or
			( sb_mixupbox and target.type == MT_MIXUP_BOX ) or
			( sb_mysterybox and target.type == MT_MYSTERY_BOX ) or
			( sb_gravitybox and target.type == MT_GRAVITY_BOX ) or
			( sb_recyclerbox and target.type == MT_RECYCLER_BOX ) or
			( sb_score1kbox and target.type == MT_SCORE1K_BOX ) or
			( sb_score10kbox and target.type == MT_SCORE10K_BOX ) or
			( sb_flameaurabox and target.type == MT_FLAMEAURA_BOX ) or
			( sb_bubblewrapbox and target.type == MT_BUBBLEWRAP_BOX ) or
			( sb_thundercoinbox and target.type == MT_THUNDERCOIN_BOX ) or
			-- Goldboxes
			( sb_pitybox_gold and target.type == MT_PITY_GOLDBOX ) or
			( sb_attractbox_gold and target.type == MT_ATTRACT_GOLDBOX ) or
			( sb_forcebox_gold and target.type == MT_FORCE_GOLDBOX ) or
			( sb_armageddonbox_gold and target.type == MT_ARMAGEDDON_GOLDBOX ) or
			( sb_whirlwindbox_gold and target.type == MT_WHIRLWIND_GOLDBOX ) or
			( sb_elementalbox_gold and target.type == MT_ELEMENTAL_GOLDBOX ) or
			( sb_sneakersbox_gold and target.type == MT_SNEAKERS_GOLDBOX ) or
			( sb_invulnbox_gold and target.type == MT_INVULN_GOLDBOX ) or
			( sb_eggmanbox_gold and target.type == MT_EGGMAN_GOLDBOX ) or
			( sb_gravitybox_gold and target.type == MT_GRAVITY_GOLDBOX ) or
			( sb_flameaurabox_gold and target.type == MT_FLAMEAURA_GOLDBOX ) or
			( sb_bubblewrapbox_gold and target.type == MT_BUBBLEWRAP_GOLDBOX ) or
			( sb_thundercoinbox_gold and target.type == MT_THUNDERCOIN_GOLDBOX ) or
			( sb_teamring and ( target.type == MT_RING_REDBOX ) or ( target.type == MT_RING_BLUEBOX ) )
		) then
			-- Illegal crossteam shooting?
			if( sb_crossteam == 0 and (
				( target.type == MT_RING_BLUEBOX and source.player.ctfteam == 1 ) or -- red on blue
				( target.type == MT_RING_REDBOX and source.player.ctfteam == 2 ) -- blue on red
			))then return nil end -- yeah I know, it's janky. Blame the wall up there
			-- Kill MOBJ
			return true
		end
	end
	return nil
end

-- Add hooks for EVERY. SINGLE. TARGET. TYPE.
-- *Why* is there no catchall itembox MT_* ?
addHook("ShouldDamage", shootableBoxes_live, MT_RING_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_PITY_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_ATTRACT_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_FORCE_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_ARMAGEDDON_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_WHIRLWIND_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_ELEMENTAL_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_SNEAKERS_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_INVULN_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_1UP_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_EGGMAN_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_MIXUP_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_MYSTERY_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_GRAVITY_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_RECYCLER_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_SCORE1K_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_SCORE10K_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_FLAMEAURA_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_BUBBLEWRAP_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_THUNDERCOIN_BOX);
addHook("ShouldDamage", shootableBoxes_live, MT_PITY_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_ATTRACT_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_FORCE_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_ARMAGEDDON_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_WHIRLWIND_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_ELEMENTAL_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_SNEAKERS_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_INVULN_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_EGGMAN_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_GRAVITY_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_FLAMEAURA_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_BUBBLEWRAP_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_THUNDERCOIN_GOLDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_RING_REDBOX);
addHook("ShouldDamage", shootableBoxes_live, MT_RING_BLUEBOX);

-- Item box types
CV_RegisterVar({"sb_ringbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_pitybox", 1, CV_NETVAR})
CV_RegisterVar({"sb_attractbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_forcebox", 1, CV_NETVAR})
CV_RegisterVar({"sb_armageddonbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_whirlwindbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_elementalbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_sneakersbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_invulnbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_1upbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_eggmanbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_mixupbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_mysterybox", 1, CV_NETVAR})
CV_RegisterVar({"sb_gravitybox", 1, CV_NETVAR})
CV_RegisterVar({"sb_recyclerbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_score1kbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_score10kbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_flameaurabox", 1, CV_NETVAR})
CV_RegisterVar({"sb_bubblewrapbox", 1, CV_NETVAR})
CV_RegisterVar({"sb_thundercoinbox", 1, CV_NETVAR})
-- Goldboxes
CV_RegisterVar({"sb_pitybox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_attractbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_forcebox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_armageddonbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_whirlwindbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_elementalbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_sneakersbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_invulnbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_eggmanbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_gravitybox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_flameaurabox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_bubblewrapbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_thundercoinbox_gold", 1, CV_NETVAR})
CV_RegisterVar({"sb_teamring", 1, CV_NETVAR})
CV_RegisterVar({"sb_crossteam", 0, CV_NETVAR}) -- Wanna shoot enemy boxes?

-- Weapon types
CV_RegisterVar({"sb_redrail", 1, CV_NETVAR})
CV_RegisterVar({"sb_bounce", 1, CV_NETVAR})
CV_RegisterVar({"sb_infinity", 1, CV_NETVAR})
CV_RegisterVar({"sb_auto", 1, CV_NETVAR})
CV_RegisterVar({"sb_scatter", 1, CV_NETVAR})
CV_RegisterVar({"sb_bomb", 1, CV_NETVAR})
CV_RegisterVar({"sb_grenade", 1, CV_NETVAR})

-- Main hook
CV_RegisterVar({"sb_enable", 1, CV_NETVAR})
COM_AddCommand("sb_help", sbhelp)
