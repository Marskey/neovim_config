local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"
local action_history = require "telescope.actions.history"
local utils = require "telescope.utils"
local action_state = require "telescope.actions.state"
actions.cycle_history_next = function(prompt_bufnr)
  local history = action_state.get_current_history()
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local line = action_state.get_current_line()

  local entry = history:get_next(line, current_picker)
  if entry == false then
    return
  end

  if entry ~= nil then
    current_picker:reset_prompt()
    current_picker:set_prompt(entry)
  end
end
-- local history = action_history.History
-- function history:get_next(line, picker)
--     if not self.enabled then
--         utils.notify("History:get_next", {
--             msg = "You are cycling to next the history item but history is disabled. Read ':help telescope.defaults.history'",
--             level = "WARN",
--         })
--         return false
--     end
--     if self._pre_get then
--         self._pre_get(self, line, picker)
--     end
--
--     local next_idx = self.index + 1
--     if next_idx <= #self.content then
--         self.index = next_idx
--         return self.content[next_idx]
--     end
--     self.index = #self.content + 1
--     return false
-- end

telescope.setup {
    defaults = {

        --prompt_prefix = " ",
        -- selection_caret = " ",
        selection_caret = " ",

        -- "hidden"    hide file names
        -- "tail"      only display the file name, and not the path
        -- "absolute"  display absolute paths
        -- "smart"     remove as much from the path as possible to only show
        --             the difference between the displayed paths.
        --             Warning: The nature of the algorithm might have a negative
        --             performance impact!
        -- "shorten"   only display the first character of each directory in
        --             the path
        -- "truncate"  truncates the start of the path when the whole path will
        --              not fit. To increase the the gap between the path and the edge.
        --              set truncate to number `truncate = 3`
        path_display = { shorten = { len = 3, exclude = { 1, 2, -2, -1 } } },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            theme = "dropdown",
            previewer = false,
            layout_config = { width = 0.6 }
        },
        live_grep = {
            theme = "dropdown",
            layout_config = {
                width = 0.9,
                -- height = 0.5
            }
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
            sort_mru = true,
            ignore_current_buffer = true
        },
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        aerial = {
            show_nesting = true,
        }
    },
}

telescope.load_extension('fzf')
