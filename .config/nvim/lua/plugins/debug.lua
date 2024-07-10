return {
	"mfussenegger/nvim-dap",
	dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },

	config = function()
		local dap = require("dap")

		-- C/Cpp/Rust debug setup with VScode lib
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "/home/ostap4ello/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		-- -- GDB setup
		-- dap.adapters.gdb = {
		-- 	type = "executable",
		-- 	command = "gdb",
		-- 	args = { "-i", "dap" },
		-- }
		--
		-- dap.configurations.c = {
		-- 	{
		-- 		name = "Launch",
		-- 		type = "gdb",
		-- 		request = "launch",
		-- 		program = function()
		-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 		end,
		-- 		cwd = "${workspaceFolder}",
		-- 		stopAtBeginningOfMainSubprogram = false,
		-- 	},
		-- }

		vim.keymap.set("n", "<leader><F5>", function()
			dap.continue()
		end, { desc = "Continue" })
		vim.keymap.set("n", "<F5>", function()
			dap.step_over()
		end, { desc = "Step over" })
		-- vim.keymap.set("n", "<F11>", function()
		-- 	dap.step_into()
		-- end)
		-- vim.keymap.set("n", "<F12>", function()
		-- 	dap.step_out()
		-- end)
		vim.keymap.set("n", "<Leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<Leader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "??" })
		vim.keymap.set("n", "<Leader>dr", function()
			dap.repl.open()
		end, { desc = "Open REPL" })
		vim.keymap.set("n", "<Leader>dl", function()
			dap.run_last()
		end, { desc = "Run last" })
		vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "Hover" })
		vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
			require("dap.ui.widgets").preview()
		end, { desc = "Preview" })
		vim.keymap.set("n", "<Leader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end, { desc = "Frames" })
		vim.keymap.set("n", "<Leader>ds", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end, { desc = "Scopes" })

		-- dapUI setup
		local dapui = require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- vim.keymap.set("n", "<Leader>dO", function()
		-- 	dapui.open()
		-- end, { desc = "[O]pen DapUI" })
		-- vim.keymap.set("n", "<Leader>dC", function()
		-- 	dapui.close()
		-- end, { desc = "[C]lose DapUI" })
		vim.keymap.set("n", "<Leader>dt", function()
			dapui.toggle()
		end, { desc = "[T]oggle DapUI" })
		vim.keymap.set("n", "<Leader>da", function()
			dapui.elements.watches.add()
		end, { desc = "Add to watches" })
		vim.keymap.set("n", "<Leader>de", function()
			dapui.elements.watches.edit()
		end, { desc = "Edit watches" })
		vim.keymap.set("n", "<Leader>dr", function()
			dapui.elements.watches.remove()
		end, { desc = "Remove from watches" })

		require("dapui").setup()
	end,
}
