return {
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = { "kevinhwang91/promise-async" },
  --   event = "BufRead",
  --   keys = {
  --     {
  --       "zR",
  --       function()
  --         require("ufo").openAllFolds()
  --       end,
  --     },
  --     {
  --       "zM",
  --       function()
  --         require("ufo").closeAllFolds()
  --       end,
  --     },
  --     {
  --       "K",
  --       function()
  --         local winid = require("ufo").peekFoldedLinesUnderCursor()
  --         if not winid then
  --           vim.lsp.buf.hover()
  --         end
  --       end,
  --     },
  --   },
  --   config = function()
  --     vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  --     vim.o.foldcolumn = "1"
  --     vim.o.foldlevel = 99
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true
  --     require("ufo").setup()
  --   end,
  -- },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    opts = function(_, opts)
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- To show number of folded lines
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts.fold_virt_text_handler = handler
    end,
  },
}

--
-- releated with issue https://github.com/kevinhwang91/nvim-ufo/issues/117#issuecomment-1465111276
-- return {
--   {
--     "kevinhwang91/nvim-ufo",
--     event = "BufRead",
--     dependencies = {
--       { "kevinhwang91/promise-async" },
--       -- {
--       --   "luukvbaal/statuscol.nvim",
--       --   config = function()
--       --     local builtin = require("statuscol.builtin")
--       --     require("statuscol").setup({
--       --       -- foldfunc = "builtin",
--       --       -- setopt = true,
--       --       relculright = true,
--       --       segments = {
--       --         { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
--       --         { text = { "%s" }, click = "v:lua.ScSa" },
--       --         { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
--       --       },
--       --     })
--       --   end,
--       -- },
--     },
--     config = function()
--       -- Fold options
--       vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
--       vim.o.foldcolumn = "1" -- '0' is not bad
--       vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
--       vim.o.foldlevelstart = 99
--       vim.o.foldenable = true
--
--       require("ufo").setup()
--     end,
--   },
-- }
