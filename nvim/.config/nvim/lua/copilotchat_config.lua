require("CopilotChat").setup({
  show_help = "yes",
  window = {
	  layout = 'vertical', -- 'vertical', 'horizontal'

  },
  prompts = {
    MyCustomPrompt = {
      prompt = 'Explain how it works.',
      system_prompt = 'You are very good at explaining stuff',
      mapping = '<leader>exp',
      description = 'My custom prompt description',
    }
  }
})
