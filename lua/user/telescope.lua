local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        preview = {
            filesize_hook = function(filepath, bufnr, opts)
                local max_bytes = 10000
                local cmd = { "head", "-c", max_bytes, filepath }
                require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
            end
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        -- selection_caret = " ",

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
        cache_picker = {
            num_pickers = 1,
        }
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
            layout_strategy = 'vertical',
            previewer = false,
            layout_config = {
                width = 0.6,
                height = 0.65,
                prompt_position = "top",
            },
            scroll_strategy = 'limit',
            sorting_strategy = 'ascending',
        },
        live_grep = {
            layout_strategy = 'vertical',
            layout_config = {
                width = 0.85,
                height = 0.85,
                preview_height = 0.4,
                prompt_position = "top",
            },
            scroll_strategy = 'limit',
            sorting_strategy = 'ascending',
        },
        buffers = {
            layout_strategy = 'vertical',
            previewer = false,
            layout_config = {
                width = 0.6,
                height = 0.65,
                prompt_position = "top",
            },
            sort_mru = true,
            ignore_current_buffer = true,
            scroll_strategy = 'limit',
            sorting_strategy = 'ascending',
        },
        pickers = {
            layout_strategy = 'center',
            layout_config = {
                width = 0.8,
                -- height = 0.5
            },
            scroll_strategy = 'limit',
            sorting_strategy = 'ascending',
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
