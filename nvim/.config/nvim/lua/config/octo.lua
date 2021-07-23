return function()
  require("octo").setup({
    default_remote = {"upstream", "origin"}; -- order to try remotes
    reaction_viewer_hint_icon = "";         -- marker for user reactions
    user_icon = " ";                        -- user icon
    timeline_marker = "";                   -- timeline marker
    timeline_indent = "2";                   -- timeline indentation
    right_bubble_delimiter = "";            -- Bubble delimiter
    left_bubble_delimiter = "";             -- Bubble delimiter
    github_hostname = "";                    -- GitHub Enterprise host
    snippet_context_lines = 4;               -- number or lines around commented lines
    file_panel = {
      size = 10,                             -- changed files panel rows
      use_icons = true                       -- use web-devicons in file panel
    },
    mappings = {
      issue = {
        close_issue = "<leader>oic",         -- close issue
        reopen_issue = "<leader>oir",        -- reopen issue
        list_issues = "<leader>oil",         -- list open issues on same repo
        reload = "<C-r>",                    -- reload issue
        open_in_browser = "<C-b>",           -- open issue in browser
        copy_url = "<C-y>",                  -- copy url to system clipboard
        add_assignee = "<leader>oaa",        -- add assignee
        remove_assignee = "<leader>oad",     -- remove assignee
        create_label = "<leader>olc",        -- create label
        add_label = "<leader>ola",           -- add label
        remove_label = "<leader>old",        -- remove label
        goto_issue = "<leader>ogi",          -- navigate to a local repo issue
        add_comment = "<leader>oca",         -- add comment
        delete_comment = "<leader>ocd",      -- delete comment
        next_comment = "]c",                 -- go to next comment
        prev_comment = "[c",                 -- go to previous comment
        react_thumbs_up = "<leader>or+",     -- add/remove upvote reaction
        react_thumbs_down = "<leader>or-",   -- add/remove downvote reaction
        react_laugh = "<leader>orl",         -- add/remove :) reaction
        react_confused = "<leader>orc",      -- add/remove :( reaction
      },
      pull_request = {
        checkout_pr = "<leader>opo",         -- checkout PR
        merge_pr = "<leader>opm",            -- merge PR
        list_commits = "<leader>opc",        -- list PR commits
        list_changed_files = "<leader>opf",  -- list PR changed files
        show_pr_diff = "<leader>opd",        -- show PR diff
        add_reviewer = "<leader>ova",        -- add reviewer
        remove_reviewer = "<leader>ovd",     -- remove reviewer request
        close_issue = "<leader>oic",         -- close PR
        reopen_issue = "<leader>oio",        -- reopen PR
        list_issues = "<leader>oil",         -- list open issues on same repo
        reload = "<C-r>",                    -- reload PR
        open_in_browser = "<C-b>",           -- open PR in browser
        copy_url = "<C-y>",                  -- copy url to system clipboard
        add_assignee = "<leader>oaa",        -- add assignee
        remove_assignee = "<leader>oad",     -- remove assignee
        create_label = "<leader>olc",        -- create label
        add_label = "<leader>ola",           -- add label
        remove_label = "<leader>old",        -- remove label
        goto_issue = "<leader>ogi",          -- navigate to a local repo issue
        add_comment = "<leader>oca",         -- add comment
        delete_comment = "<leader>ocd",      -- delete comment
        next_comment = "]c",                 -- go to next comment
        prev_comment = "[c",                 -- go to previous comment
        react_thumbs_up = "<leader>or+",     -- add/remove upvote reaction
        react_thumbs_down = "<leader>or-",   -- add/remove downvote reaction
        react_laugh = "<leader>orl",         -- add/remove :) reaction
        react_confused = "<leader>orc",      -- add/remove :( reaction
      },
      review_thread = {
        goto_issue = "<leader>ogi",          -- navigate to a local repo issue
        add_comment = "<leader>oca",         -- add comment
        add_suggestion = "<leader>osa",      -- add suggestion
        delete_comment = "<leader>ocd",      -- delete comment
        next_comment = "]c",                 -- go to next comment
        prev_comment = "[c",                 -- go to previous comment
        select_next_entry = "]q",            -- move to previous changed file
        select_prev_entry = "[q",            -- move to next changed file
        close_review_tab = "<C-c>",          -- close review tab
        react_thumbs_up = "<leader>or+",     -- add/remove upvote reaction
        react_thumbs_down = "<leader>or-",   -- add/remove downvote reaction
        react_laugh = "<leader>orl",         -- add/remove :) reaction
        react_confused = "<leader>orc",      -- add/remove :( reaction
      },
      submit_win = {
        approve_review = "<C-a>",            -- approve review
        comment_review = "<C-m>",            -- comment review
        request_changes = "<C-r>",           -- request changes review
        close_review_tab = "<C-c>",          -- close review tab
      },
      review_diff = {
        add_review_comment = "<leader>oca",    -- add a new review comment
        add_review_suggestion = "<leader>osa", -- add a new review suggestion
        focus_files = "<leader>e",           -- move focus to changed file panel
        toggle_files = "<leader>b",          -- hide/show changed files panel
        next_thread = "]t",                  -- move to next thread
        prev_thread = "[t",                  -- move to previous thread
        select_next_entry = "]q",            -- move to previous changed file
        select_prev_entry = "[q",            -- move to next changed file
        close_review_tab = "<C-c>",          -- close review tab
        toggle_viewed = "<leader><leader>o", -- toggle viewer viewed state
      },
      file_panel = {
        next_entry = "j",                    -- move to next changed file
        prev_entry = "k",                    -- move to previous changed file
        select_entry = "<cr>",               -- show selected changed file diffs
        refresh_files = "R",                 -- refresh changed files panel
        focus_files = "<leader>e",           -- move focus to changed file panel
        toggle_files = "<leader>b",          -- hide/show changed files panel
        select_next_entry = "]q",            -- move to previous changed file
        select_prev_entry = "[q",            -- move to next changed file
        close_review_tab = "<C-c>",          -- close review tab
        toggle_viewed = "<leader><leader>o", -- toggle viewer viewed state
      }
    }
  })
end
