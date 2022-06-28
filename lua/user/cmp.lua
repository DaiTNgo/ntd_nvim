local cmp_status_ok, cmp = pcall(require, "cmp")

local compare = require('cmp.config.compare')

if not cmp_status_ok then
  return
end

local lspkind = require('lspkind')

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- local compare = require("cmp.config.compare")

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local source_mapping = {
  nvim_lsp = "[LSP]",
  path = "[Path]",
  -- cmp_tabnine = "[TN]",
  buffer = "[Buffer]",
  luasnip = "[Snippet]",
  nvim_lua = "[NVIM_LUA]",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- move down and up in popup show suggestion
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- ["<C-j>"] = cmp.mapping.select_next_item(),
    -- unknow
    -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- show suggestion
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  -- sorting = {
  --   priority_weight = 2,
  --   comparators = {
  --     require('cmp_tabnine.compare'),
  --     compare.kind,
  --     compare.exact,
  --     compare.score,
  --     compare.offset,
  --     compare.order,
  --     compare.recently_used,
  --     compare.sort_text,
  --     compare.length,
  --   },
  -- },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    -- format = function(entry, vim_item)
    --   -- Kind icons
    --   vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    --
    --   vim_item.menu = ({
    --     path = "[Path]",
    --     buffer = "[Buffer]",
    --     luasnip = "[Snippet]",
    --     nvim_lsp = "[LSP]",
    --     nvim_lua = "[NVIM_LUA]",
    --     cmp_tabnine = "[TN]"
    --   })[entry.source.name]
    --   return vim_item
    -- end,
    format = function(entry, vim_item)
      -- vim_item.kind = lspkind.presets.default[vim_item.kind]
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      local menu = source_mapping[entry.source.name]
      -- if entry.source.name == 'cmp_tabnine' then
      --   if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
      --     menu = entry.completion_item.data.detail .. ' ' .. menu
      --   end
      --   vim_item.kind = ''
      -- end
      vim_item.menu = menu
      return vim_item
    end
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
    -- { name = "cmp_tabnine" },
    { name = "nvim_lua" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered()
  },

  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  view = {
    entries = "native", -- can be "custom", "wildmenu" or "native"
  },
})

-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
--   max_lines = 1000;
--   max_num_results = 20;
--   sort = true;
--   run_on_every_keystroke = true;
--   snippet_placeholder = '..';
--   ignored_file_types = { -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true,
--     css = true;
--     html = true;
--   };
--   show_prediction_strength = false;
-- })
