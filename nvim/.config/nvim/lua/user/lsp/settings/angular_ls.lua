return {
	on_setup = function(server)
		server.setup({
			cmd = { "ngserver", "--stdio" },
			on_new_config = function(new_config, new_root_dir)
				local mason_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules"
				local project_path = require("lspconfig.util").find_node_modules_ancestor(new_root_dir)
				local project_node_modules = project_path and (project_path .. "/node_modules") or ""

				local probe_locations = { mason_path }
				if project_node_modules ~= "" then
					table.insert(probe_locations, project_node_modules)
				end

				new_config.cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					table.concat(probe_locations, ","),
					"--ngProbeLocations",
					table.concat(probe_locations, ","),
				}
			end,
		})
	end,
}
