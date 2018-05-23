
ConfigurationManager.config_file("paths.lua")

local MASTER_OPACITY = 1

local COLORS_CONFIG = {
	DEFAULT = {r = 1, g = 0, b = 1, a = 1 * MASTER_OPACITY},
	OUTLINE = {r = 0, g = 0, b = 0, a = 1 * MASTER_OPACITY},
	BAD_VALUE = {r = 1, g = 0, b = 0, a = 1 * MASTER_OPACITY},
	WARNING_VALUE = {r = 1, g = 1, b = 0, a = 1 * MASTER_OPACITY},
	GOOD_VALUE = {r = 0, g = 1, b = 0, a = 1 * MASTER_OPACITY},
	NONE = {r = 0, g = 0, b = 0, a = 0 * MASTER_OPACITY}
}

local DEFAULT_HEADER_CONFIG = {
	enabled = false,

	color = COLORS_CONFIG.DEFAULT,
	font_size = 20,
	underline = {
		enabled = true,
		color = COLORS_CONFIG.DEFAULT
	}
}

local FrameDataProvider_formats_short = {
	header = "Frame timings",
	fps = "FPS: ",
	fps_number = "%.2f",
	average_frame_duration = "AFD: %.2f ms",
	osd_averate_time_spent_per_frame =
	"OSDATSPF: %.2f ms",
	no_data = "Collecting..."
}

local FrameDataProvider_formats_long = {
	header = "Frame timings",
	fps = "Frames Per Second: ",
	fps_number = "%.2f",
	average_frame_duration = "Average Frame Duration: %.2f ms",
	osd_averate_time_spent_per_frame =
	"Average time spent by OSD per frame: %.2f ms",
	no_data = "Collecting frame data..."
}

local LibsensorsDataProvider_formats = {
	header = "Sensors"
}

local NVMLDataProvider_formats_long = {
	header = "NVIDIA GPUs",
	temperature = "Temperature: ",
	throttled = "(thrtl)",
	graphics_clock = "Graphics clock: %d",
	sm_clock = "SM clock: %d",
	memory_clock = "Memory clock: %d",
	gpu_utilisation = "GPU utilisation: %d%%",
	memory_utilisation = "Memory utilisation: %d%%"
}

local NVMLDataProvider_formats_short = {
	header = "GPUs",
	temperature = "Temp: ",
	throttled = "(thrtl)",
	graphics_clock = "GPU clk: %d",
	sm_clock = "SM clk: %d",
	memory_clock = "Mem clk: %d",
	gpu_utilisation = "GPU usg: %d%%",
	memory_utilisation = "Mem usg: %d%%"
}

local OSD_CONFIG = {
	refresh_time = 1000,

	align_to_h = "left",
	align_to_v = "top",

	offset_x = 0,
	offset_y = 0,

	font = "Ubuntu:Bold",
	font_size = 20,
	text_alignment = "left",
	outline = {
		type = "outer",
		thickness = 0.5,
		color = COLORS_CONFIG.OUTLINE
	},

	gamma = 1,
	lcd_filter_enabled = true,

	underline = {
		enabled = false,
		color = COLORS_CONFIG.NONE
	},

	overline = {
		enabled = false,
		color = COLORS_CONFIG.NONE
	},

	strikethrough = {
		enabled = false,
		color = COLORS_CONFIG.NONE
	},

	color = COLORS_CONFIG.DEFAULT,
	background_color = COLORS_CONFIG.NONE,

	toggle_key_combo = {
		main_key = "F10",
		modifiers = {"shift"}
	},

	osd_data_providers = {
		{
			path = "plugins/OSD/dataproviders/FrameDataProvider",
			enabled = true,
			config = {

				low_fps = 29,
				refresh_time = 3000,

				acceptable_value_color = COLORS_CONFIG.GOOD_VALUE,
				unacceptable_value_color = COLORS_CONFIG.BAD_VALUE,

				data_order = {
					"FPS"
				},

				formatter_function = ConfigurationManager
					.config_file("OSD/dataproviders/FrameDataProvider/formatterfunction.lua"),

				header_style = DEFAULT_HEADER_CONFIG,
				format = FrameDataProvider_formats_short
			}
		},
		{
			path = "plugins/OSD/dataproviders/LibsensorsDataProvider",
			enabled = false,
			config = {

				chip_filter_function = function(self, chip)
					return true
				end,

				feature_filter_function = function(self, chip, feature)
					return true
				end,

				max_temperature_warning_threshold = 10,
				default_temperature_color = COLORS_CONFIG.DEFAULT,
				good_temperature_color = COLORS_CONFIG.GOOD_VALUE,
				warning_temperature_color = COLORS_CONFIG.WARNING_VALUE,
				overheating_temperature_color = COLORS_CONFIG.BAD_VALUE,

				formatter_function = ConfigurationManager
					.config_file("OSD/dataproviders/LibsensorsDataProvider/formatterfunction.lua"),

				header_style = DEFAULT_HEADER_CONFIG,

				format = LibsensorsDataProvider_formats
			}
		},
		{
			path = "plugins/OSD/dataproviders/NVMLDataProvider",
			enabled = false,
			config = {

				default_temperature_color = COLORS_CONFIG.DEFAULT,
				normal_temperature_color = COLORS_CONFIG.GOOD_VALUE,
				slowdown_temperature_color = COLORS_CONFIG.WARNING_VALUE,
				shutdown_temperature_color = COLORS_CONFIG.BAD_VALUE,

				data_order = {
					"temperature",
					"gpu_utilisation",
					"memory_utilisation",
					"graphics_clock",
					"memory_clock",
					"sm_clock",
				},

				formatter_function = ConfigurationManager
					.config_file("OSD/dataproviders/NVMLDataProvider/formatterfunction.lua"),

				header_style = DEFAULT_HEADER_CONFIG,

				format = NVMLDataProvider_formats_long
			}
		}
	}
}

TIME_RECORDER_CONFIG = {
	benchmark_output_directory = "/tmp/",

	start_benchmark_key = {
		main_key = "F9",
		modifiers = {"shift"}
	},

	end_benchmark_key = {
		main_key = "F9",
		modifiers = {"shift"}
	},

	enable_minimise_overhead_mode_during_benchmark = true
}

GLXOSD_CONFIG = {
		plugins = {
			{
				path = "plugins/OSD/OSD",
				enabled = true,
				config = OSD_CONFIG
			},

			{
				path = "plugins/TimeRecorder/TimeRecorder",
				enabled = true,
				config = TIME_RECORDER_CONFIG
			}
		}
}

return GLXOSD_CONFIG
