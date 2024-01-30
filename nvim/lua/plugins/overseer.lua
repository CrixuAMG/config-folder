return {
  {
    "stevearc/overseer.nvim",
    opts = {},
    keys = {
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle tasks" },
      { "<leader>ol", "<cmd>OverseerRestartLast<cr>", desc = "Restart last task" },
    },
    config = function()
        vim.cmd.cnoreabbrev("OS OverseerShell")

        vim.api.nvim_create_user_command("OverseerRestartLast", function()
            local overseer = require("overseer")
            local task_list = require("overseer.task_list")
            local tasks = overseer.list_tasks({ status = {
                overseer.STATUS.SUCCESS,
                overseer.STATUS.FAILURE,
                overseer.STATUS.CANCELED,
            }, sort = task_list.sort_finished_recently })
            if vim.tbl_isempty(tasks) then
                vim.notify("No tasks found", vim.log.levels.WARN)
            else
                local most_recent = tasks[1]
                overseer.run_action(most_recent, "restart")
            end
        end, {})
    end
  },
}
