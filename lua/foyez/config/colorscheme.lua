local status, _ = pcall(vim.cmd, "colorscheme tokyonight-moon")
if not status then
	print("Colorscheme not found!")
	return
end

vim.cmd [[highlight DashboardHeader guifg=#ff5555 gui=bold]]
