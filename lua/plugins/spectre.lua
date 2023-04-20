return {
  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<leader>sp",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Search on current file (spectre)",
      },
    },
  },
}
