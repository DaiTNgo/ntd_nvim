local status_ok, save = pcall(require, "auto-save")
if not status_ok then
	return
end
save.setup({
	debounce_delay = 1000,
	execution_message = {
		message = function() -- message to print on save
			return ("AutoSave: " .. vim.fn.strftime("%H:%M:%S"))
		end,
		dim = 0.18, -- dim the color of `message`
		cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
	},
	trigger_events = { "BufLeave", "FocusLost" }, -- { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
	--, "BufWinLeave", "TabLeave", "WinLeave"
})
