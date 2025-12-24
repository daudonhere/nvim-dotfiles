return {
  'gisketch/triforce.nvim',
  dependencies = { 'nvzone/volt' },
  config = function()
    require('triforce').setup({
      enabled = true,
      gamification = {
        enabled = true,
        level_up = true,
        achievements = true,
      },
      keymap = {
        show_profile = '<leader>tp',
      },
      auto_save_interval = 300,
      custom_languages = {
        gleam = { icon = '✨', name = 'Gleam' },
        odin = { icon = '🔷', name = 'Odin' },
      },
      level_progression = {
        tier_1 = { min_level = 1, max_level = 10, xp_per_level = 300 },
        tier_2 = { min_level = 11, max_level = 20, xp_per_level = 500 },
        tier_3 = { min_level = 21, max_level = math.huge, xp_per_level = 1000 },
      },
      xp_rewards = {
        char = 1,
        line = 1,
        save = 50,
      },
      ignore_ft = {},
      heat_highlights = {
        TriforceHeat1 = '#39d353',
        TriforceHeat2 = '#26a641',
        TriforceHeat3 = '#006d32',
        TriforceHeat4 = '#0e4429',
      },
      debug = false,
    })
  end,
}