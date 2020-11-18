Config = {}

Config.DoorList = {


	--
	-- Valentine Sheriff Office
	--

	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-276.04, 802.73, 118.41),
		textCoords  = vector3(-275.02, 802.84, 119.43),
		locked = true,
		objYaw = 10.0,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-275.85, 812.02, 118.41),
		textCoords  = vector3(-277.06, 811.83, 119.38),
		objYaw = -170.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-270.77, 810.02, 118.39),
		textCoords  = vector3(-270.37, 809.02, 119.39),
		objYaw = -80.0,
		locked = true,
		distance = 1.5
	},

	--cell area
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-275.03, 809.27, 118.36),
		textCoords  = vector3(-274.89, 808.03, 119.39),
		objYaw = -80.0,
		locked = true,
		distance = 2
	},
	--cells
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-273.47, 809.96, 118.36),
		textCoords  = vector3(-272.23, 810.1, 119.39),
		objYaw = 10.0,
		locked = true,
		distance = 1.5
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-272.06, 808.25, 118.36),
		textCoords  = vector3(-273.3, 808.12, 119.39),
		objYaw = -170.0,
		locked = true,
		distance = 1.5
	},

	--
	-- Rhodes Sheriff Office
	--

	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(1359.71, -1305.97, 76.76),
		textCoords  = vector3(1358.42, -1305.71, 77.72),
		objYaw = 160.0,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(1359.12, -1297.56, 76.78),
		textCoords  = vector3(1358.51, -1298.95,77.78),
		objYaw = -110.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(1357.6, -1301.9, 76.78),
		textCoords  = vector3(1357.6, -1301.9,77.78),
		objYaw = 70.0,
		locked = true,
		distance = 3.0
	},

	--
	-- Blackwater Sheriff Office
	--

	{
		textCoords = vector3(-757.27, -1269.34, 44.04),
		authorizedJobs = { 'Sceriffo' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = 90.0,
				objCoords = vector3(-757.05, -1268.49, 43.06)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = 90.0,
				objCoords = vector3(-757.05, -1269.93, 43.06)
			}
		}
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-769.1, -1269.5, 43.0),
		textCoords  = vector3(-769.1, -1269.5, 44.0),
		objYaw = -90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-766.0, -1264.2, 43.0),
		textCoords  = vector3(-766.0, -1264.2, 44.0),
		objYaw = 90.0,
		locked = true,
		distance = 1.5
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-763.5, -1263.1, 43.1),
		textCoords  = vector3(-763.5, -1263.1, 44.1),
		objYaw = -90.0,
		locked = true,
		distance = 1.5
	},
	
	--
	--Strawberry sheriff
	--
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-1807.0, -350.8, 163.7),
		textCoords  = vector3(-1807.0, -350.8, 164.7),
		objYaw = -115.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-1813.0, -345.5, 163.7),
		textCoords  = vector3(-1813.0, -345.5, 164.7),
		objYaw = -115.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-1814.6, -353.8, 160.5),
		textCoords  = vector3(-1814.6, -353.8, 161.5),
		objYaw = -115.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-1811.5, -352.2, 160.4),
		textCoords  = vector3(-1811.5, -352.2, 161.4),
		objYaw = -25.0,
		locked = true,
		distance = 3.0
	},
	
	--
	--Tumbleweed jail
	--
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-5528.3, -2930.7, -1.4),
		textCoords  = vector3(-5528.3, -2930.7, -0.4),
		objYaw = -155.0,
		locked = true,
		distance = 3.0
	},
	
	--
	--Armadillo sheriff
	--
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-3625.0, -2604.8, -12.3),
		textCoords  = vector3(-3625.0, -2604.8, -13.3),
		objYaw = -245.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-3620.7, -2600.8, -12.3),
		textCoords  = vector3(-3620.7, -2600.8, -13.3),
		objYaw = -65.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(-3618.9, -2604.7, -12.3),
		textCoords  = vector3(-3618.9, -2604.7, -13.3),
		objYaw = -65.0,
		locked = true,
		distance = 3.0
	},
	
	--
	--Saint denis police
	--
	{
		authorizedJobs = { 'Sceriffo' },
		objCoords  = vector3(2502.9, -1307.9, 48.0),
		textCoords  = vector3(2502.9, -1307.9, 49.0),
		objYaw = 0.0,
		locked = true,
		distance = 3.0
	},
	
	--Saloon PolenTz, MixROx
	
	{
		authorizedJobs = { 'blackjack' },
		objCoords  = vector3(-243.8, 765.8, 118.2),
		textCoords  = vector3(-243.8, 765.8, 118.2),
		objYaw = 110.0,
		locked = true,
		distance = 3.0
	},
	
	{
		authorizedJobs = { 'blackjack' },
		objCoords  = vector3(-239.0, 773.8, 118.1),
		textCoords  = vector3(-239.0, 773.4, 118.1),
		objYaw = -70.0,
		locked = true,
		distance = 3.0
	},

	{
		authorizedJobs = { 'Saloon' },
		objCoords  = vector3(1788.3, -811.2, 189.5),
		textCoords  = vector3(1788.3, -811.2, 189.5),
		objYaw = -140.0,
		locked = true,
		distance = 3.0
	},

	{
		authorizedJobs = { 'Saloon' },
		objCoords  = vector3(1787.3, -812.1, 189.5),
		textCoords  = vector3(1787.3, -812.1, 189.5),
		objYaw = 45.0,
		locked = true,
		distance = 3.0
	},

	{
		authorizedJobs = { 'Medico' },
		objCoords  = vector3(-287.0, 809.7, 119.4),
		textCoords  = vector3(-287.2, 809.7, 119.4),
		objYaw = 192.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'Medico' },
		objCoords  = vector3(-281.1, 815.9, 119.4),
		textCoords  = vector3(-281.1, 815.7, 119.4),
		objYaw = 100.0,
		locked = true,
		distance = 3.0
	}
}
