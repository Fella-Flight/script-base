--  CTLD Configuration - At War
--  ----------------------------------------------------------------------------
--  Aaron Robertson (Amloris)
--  July 2019
--  ----------------------------------------------------------------------------
--  Program Desciption:
--    This configuration file controls how CTLD placed assets are spawned and 
--    how they interact with the game. By modifying this file, one can dictate 
--    which units are persistent, if they can be driven and grouped with other
--    vehicles, how many lives a unit recieves after it is placed, and more.
--
--  Program Use:
--
--  Changelog:
--  2019-07-31  AR, Original Version
-- ----------------------------------------------------------------------------

local ctld_config = {}

ctld_config.unit_config = {
	["MLRS M270"] = {
		["type"] = "MLRS",
		["name"] = "CTLD_MLRS_M270 #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["M109 Paladin"] = {
		["type"] = "M-109",
		["name"] = "CTLD_M109 #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["M1A1 Abrams"] = {
		["type"] = "M-1 Abrams",
		["name"] = "CTLD_M1A1 #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["HMMWV JTAC"] = {
		["type"] = "Hummer",
		["name"] = "CTLD_JTAC #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["M818 Transport"] = {
		["type"] = "M 818",
		["name"] = "CTLD_M818 #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["Flugabwehrkanonenpanzer Gepard"] = {
		["type"] = "Gepard",
		["name"] = "CTLD_Gepard #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["M163 Vulcan"] = {
		["type"] = "Vulcan",
		["name"] = "CTLD_Vulcan #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["M1097 Avenger"] = {
		["type"] = "M1097 Avenger",
		["name"] = "CTLD_Avenger #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["M48 Chaparral"] = {
		["type"] = "M48 Chaparral",
		["name"] = "CTLD_Chaparral #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	},

	["Roland ADS"] = {
		["type"] = "Roland ADS",
		["name"] = "CTLD_Roland #",
		["playerCanDrive"] = true,
		["skill"] = "Excellent",
	}
}

ctld_config.unit_index = {
	M270_Index = 1,
	M109_Index = 1,
	M1A1_Index = 1,
	JTAC_Index = 1,
	M818_Index = 1,
	Gepard_Index = 1,
	Vulcan_Index = 1,
	Avenger_Index = 1,
	Chaparral_Index = 1,
	Roland_Index = 1,
}

return ctld_config

