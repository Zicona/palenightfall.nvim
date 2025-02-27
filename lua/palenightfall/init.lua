local highlight = require('palenightfall.internal').highlight

--vim.opt.guicursor = {'a:ver25'}


local M = {}

---@alias PalenightfallHighlightConfig table<string, PalenightfallHighlight>

---Color definitions.
---
---@type table<string, string>
M.colors = {
  background = '#292d3e',
  foreground = '#DDDDDD',

  keyword = '#b6c1e1',
  parameter = '#ee6576',
  cursorLnBg = '#383838',
  cursorLnFg = '#ffffff',

  background_darker = '#232534',
  --highlight = '#6e5f7c',
  highlight = '#ffcb6b',
  references = '#2e2e41',  -- Mix 19 background / 1 purple
  selection = '#383838',
  statusline = '#1d1f2b',
  foreground_darker = '#7982b4',
  line_numbers = '#787878',
  comments = '#6D6F7F',

  red = '#ff5370',
  orange = '#f78c6c',
  yellow = '#ffcb6b',
  green = '#c3e88d',
  cyan = '#89ddff',
  blue = '#82aaff',
  paleblue = '#b2ccd6',
  purple = '#D49BFD',
  brown = '#c17e70',
  pink = '#f07178',
  violet = '#bb80b3',

  -- Mix 6 background / 10 color
  red_dark = '#9e4057',
  orange_dark = '#9a6054',
  blue_dark = '#5970a6',
  green_dark = '#7d9367',

  -- Diff change
  -- Mix 7 background / 1 #00BE6A
  diff_add_background = '#203b3d',
  -- Mix 2 background / 1 #00BE6A
  diff_add_highlight = '#1c4e44',
  -- Mix 5 background / 1 red
  diff_delete_background = '#492f41',
  -- Mix 2 background / 1 red
  diff_delete_hightlight = '#6e364a',
}

---Configure the colors used for highlights.
---
---@param overrides table<string, string> Color overrides following the same

---format as `colors`
function M.configure_colors(overrides)
  M.colors = vim.tbl_deep_extend('force', M.colors, overrides or {})
end

---Table of all highlights that this plugin sets up.
---
---Can be customized with `configure_highlights`.
---
---@type PalenightfallHighlightConfig
M.highlights = nil

---Configure highlights and override the given ones
---
---@param overrides PalenightfallHighlightConfig Will be merged reqursively 
---with the defaults
---@param transparent ?boolean
function M.configure_highlights(overrides, transparent)
  local c = M.colors

  ---@type PalenightfallHighlightConfig
  local default_highlights = {
    -- UI elements
    LineNr            = { fg = c.line_numbers },
    CursorLine        = { bg = c.cursorLnBg },
    CursorLineNr      = { fg = c.cursorLnFg },
    CursorColumn      = { bg = c.cursorLnBg },
    Cursor            = { fg = c.background, bg = c.blue },
    TermCursor        = { fg = c.background, bg = c.blue },
    ColorColumn       = { bg = c.background_darker },
    Search            = { bg = c.highlight , fg = c.background },
    IncSearch         = { bg = c.pink , fg = c.background },
    CurSearch         = { link = 'IncSearch' },
    Visual            = { bg = c.selection },
    MatchParen        = { bg = c.references },
    SignColumn        = { bg = 'NONE' },
    FoldColumn        = { fg = c.line_numbers, bg = 'NONE' },
    Folded            = { fg = c.comments, bg = c.background_darker },
    VertSplit         = { fg = c.statusline, bg = c.background },
    Statusline        = { fg = c.foreground, bg = c.statusline },
    StatuslineNC      = { fg = c.foreground_darker, bg = c.statusline },
    TabLine           = { fg = c.foreground, bg = c.statusline },
    TabLineFill       = { fg = c.foreground, bg = c.statusline },
    TabLineSel        = { fg = c.foreground, bg = c.background },
    PMenu             = { bg = c.background_darker },
    PMenuSBar         = { bg = c.background_darker },
    PMenuThumb        = { bg = c.background },
    PMenuSel          = { bg = "#8c509b" },
    NormalFloat       = { bg = c.background_darker },
    FloatBorder       = { fg = c.background_darker, bg = c.background_darker },
    Question          = { fg = c.green },
    MoreMsg           = { fg = c.green },
    Error             = { fg = c.red },
    ErrorMsg          = { fg = c.red },
    NvimInternalError = { fg = c.red },
    WarningMsg        = { fg = c.orange },
    Directory         = { fg = c.blue },
    Conceal           = { fg = c.brown },

    -- Syntax
    Normal      = { fg = c.foreground, bg = transparent and 'NONE' or c.background },
    Identifier  = { fg = c.foreground },
    Comment     = { fg = c.comments, italic = true },
    NonText     = { fg = c.purple },
    Keyword     = { fg = c.purple },
    Repeat      = { fg = c.purple },
    Conditional = { fg = c.purple },
    Statement   = { fg = c.purple },
    Include     = { fg = c.purple },
    Function    = { fg = c.blue },
    String      = { fg = c.green },
    Delimiter   = { fg = c.foreground },
    Operator    = { fg = c.purple },
    PreProc     = { fg = c.cyan },
    Special     = { fg = c.violet },
    Constant    = { fg = c.orange },
    Todo        = { fg = c.orange },
    Title       = { fg = c.yellow },
    Type        = { fg = c.keyword },
    Tag         = { fg = c.yellow },
    SpellBad    = { undercurl = true, sp = c.orange },
    SpellCap    = { undercurl = true, sp = c.blue },
    SpellRare   = { undercurl = true, sp = c.violet },
    SpellLocal  = { undercurl = true, sp = c.cyan },
    Noise       = { fg = c.cyan },
    SpecialKey  = { fg = c.purple },

    -- Git
    DiffAdd                = { bg = c.diff_add_background },
    DiffDelete             = { bg = c.background, fg = c.line_numbers },
    DiffChange             = { bg = c.diff_add_background },
    DiffText               = { bg = c.diff_add_highlight },
    gitcommitHeader        = { fg = c.purple },
    gitcommitOverflow      = { fg = c.red },
    gitcommitUnmerged      = { fg = c.green },
    gitcommitSelectedFile  = { fg = c.green },
    gitcommitDiscardedFile = { fg = c.red },
    gitcommitUnmergedFile  = { fg = c.yellow },
    gitcommitSelectdType   = { fg = c.green },
    gitcommitSummary       = { fg = c.blue },
    gitcommitDiscardedType = { fg = c.red },

    -- Latex semantics Tokens

    ['@markup.math']    = { link = 'Keyword' },
    ['@markup.environment']    = { link = 'Keyword' },
    ['@markup.environment.name']    = { link = 'Keyword' },
    ['@punctuation.special'] = { link = 'Function' },

    -- LSP
    DiagnosticError                  = { fg = c.red },
    DiagnosticUnderlineError         = { fg = 'NONE', undercurl = true, sp = c.red },
    DiagnosticWarn                   = { fg = c.orange },
    DiagnosticUnderlineWarn          = { fg = 'NONE', undercurl = true, sp = c.orange },
    DiagnosticInfo                   = { fg = c.blue },
    DiagnosticUnderlineInfo          = { fg = 'NONE', undercurl = true, sp = c.blue },
    DiagnosticHint                   = { fg = c.foreground_darker },
    DiagnosticUnderlineHint          = { fg = c.comments, undercurl = true, sp = c.comments },
    LspReferenceText                 = { bg = c.references },
    LspReferenceRead                 = { bg = c.references },
    LspReferenceWrite                = { bg = c.references },
    LspDiagnosticsVirtualTextError   = { fg = '#9e4057' },
    LspDiagnosticsVirtualTextWarning = { fg = '#9a6054' },


    ['@lsp.mod.classScope'] = { fg = c.yellow },
    ['@lsp.mod.defaultLibrary'] = { link = 'Keyword' }, -- auto keyword in cpp

    -- Treesitter
    ['@constructor']      = { link = 'Type' },
    ['@tag']              = { link = 'Tag' },
    ['@tag.delimiter']    = { fg = c.foreground_darker },
    ['@tag.attribute']    = { link = 'Normal' },
    ['@variable.builtin'] = { link = 'Keyword' },
    ['@variable']         = { link = 'Normal' },
    ['@variable.parameter'] = { fg   = c.parameter},
    ['@function.builtin'] = { link = 'Function' },
    ['@constant.builtin'] = { link = 'Constant' },
    ['@text.literal']     = { fg = c.foreground_darker },
    ['@text.title']       = { link = 'Title' },
    ['@text.uri']         = { fg = c.blue, underline = true },
    ['@text.reference']   = { fg = c.green },
    ['@text.strong']      = { bold = true },
    ['@text.emphasis']    = { italic = true },
    ['@type.qualifier']   = { link = 'Keyword' },
    ['@type.builtin']   = { link = 'Keyword' },

    -- DEPRECATED: nvim-treesitter has removed these highlight groups
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2293#issuecomment-1279974776
    TSConstructor     = { fg = c.yellow },
    TSTag             = { fg = c.yellow },
    TSTagDelimiter    = { fg = c.foreground_darker },
    TSVariableBuiltin = { fg = c.orange },
    TSVariable        = { fg = c.foreground },
    TSKeywordOperator = { fg = c.purple },
    TSConstBuiltin    = { fg = c.orange },
    TSFuncBuiltin     = { fg = c.blue },
    TSLiteral         = { fg = c.foreground_darker },
    TSNote            = { fg = c.cyan },

    -- Markdown
    markdownCode          = { fg = c.foreground_darker },
    markdownCodeDelimiter = { fg = c.foreground_darker },

    -- Vimscript
    vimOption = { fg = c.yellow },

    -- plasticboy/vim-markdown
    mkdHeading       = { fg = c.green },
    mkdListItem      = { fg = c.cyan },
    mkdCode          = { fg = c.foreground_darker },
    mkdCodeDelimiter = { fg = c.foreground_darker },

    -- lewis6991/gitsigns.nvim
    GitSignsAdd           = { fg = c.green },
    GitSignsChange        = { fg = c.orange },
    GitSignsDelete        = { fg = c.red },
    GitSignsDeletePreview = { fg = c.foreground, bg = c.diff_delete_background },
    GitSignsAddInline     = { bg = c.diff_add_highlight },
    GitSignsDeleteInline  = { bg = c.diff_delete_hightlight },

    -- tpope/vim-fugitive
    diffAdded   = { fg = c.green },
    diffRemoved = { fg = c.red },

    -- hrsh7th/nvim-cmp
    CmpDocumentation   = { bg = c.background_darker },
    CmpItemAbbrDefault = { fg = c.foreground },

    CmpItemAbbr           = { fg = c.foreground },
    CmpItemAbbrDeprecated = { fg = c.foreground_darker, strikethrough = true },
    CmpItemAbbrMatch      = { fg = c.blue },
    CmpItemAbbrMatchFuzzy = { fg = c.blue },

    CmpItemMenu = { fg = c.comments },

    CmpItemKindDefault = { fg = c.foreground_darker },

    CmpItemKindKeyword   = { fg = c.purple },
    CmpItemKindReference = { fg = c.purple },
    CmpItemKindValue     = { fg = c.purple },
    CmpItemKindVariable  = { fg = c.purple },

    CmpItemKindConstant   = { fg = c.orange },
    CmpItemKindEnum       = { fg = c.orange },
    CmpItemKindEnumMember = { fg = c.orange },
    CmpItemKindOperator   = { fg = c.orange },
    CmpItemKindField      = { fg = c.orange },

    CmpItemKindFunction = { fg = c.blue },
    CmpItemKindMethod   = { fg = c.blue },

    CmpItemKindConstructor = { fg = c.yellow },
    CmpItemKindClass       = { fg = c.yellow },
    CmpItemKindInterface   = { fg = c.yellow },
    CmpItemKindStruct      = { fg = c.yellow },
    CmpItemKindEvent       = { fg = c.yellow },
    CmpItemKindUnit        = { fg = c.yellow },
    CmpItemKindFile        = { fg = c.yellow },
    CmpItemKindFolder      = { fg = c.yellow },

    CmpItemKindModule        = { fg = c.green },
    CmpItemKindProperty      = { fg = c.green },
    CmpItemKindTypeParameter = { fg = c.green },
    CmpItemKindSnippet       = { fg = c.green },
    CmpItemKindText          = { fg = c.green },

    -- nvim-telescope/telescope.nvim
    TelescopeNormal         = { bg = c.background_darker },
    TelescopeBorder         = { fg = c.background_darker, bg = c.background_darker },
    TelescopeMatching       = { fg = c.blue },
    TelescopePromptNormal   = { bg = c.references },
    TelescopePromptBorder   = { fg = c.references, bg = c.references },
    TelescopePromptTitle    = { bg = c.references },
    TelescopePromptPrefix   = { fg = c.blue },
    TelescopeSelectionCaret = { fg = c.blue, bg = c.highlight },
    TelescopeSelection      = { bg = c.references },

    -- kyazdani42/nvim-tree.lua
    NvimTreeRootFolder = { fg = c.green },
    NvimTreeGitDirty   = { fg = c.green },

    -- rcarriga/nvim-notify
    NotifyERRORBorder = { fg = c.red_dark },
    NotifyERRORIcon   = { fg = c.red },
    NotifyERRORTitle  = { fg = c.red },
    NotifyWARNBorder  = { fg = c.orange_dark },
    NotifyWARNIcon    = { fg = c.orange },
    NotifyWARNTitle   = { fg = c.orange },
    NotifyINFOBorder  = { fg = c.green_dark },
    NotifyINFOIcon    = { fg = c.green },
    NotifyINFOTitle   = { fg = c.green },
    NotifyDEBUGBorder = { fg = c.foreground_darker },
    NotifyDEBUGIcon   = { fg = c.foreground_darker },
    NotifyDEBUGTitle  = { fg = c.foreground_darker },
    NotifyLogTitle    = { fg = c.yellow },
    NotifyBackground  = { bg = c.background },

    -- folke/lazy.nvim
    LazyNormal = { bg = c.background_darker },

    -- folke/lazy.nvim
		SnacksIndentScope = { fg = c.highlight },
		SnacksIndent= { fg = c.comments },

	  -- 'MeanderingProgrammer/render-markdown.nvim',
		RenderMarkdownCode = { bg = c.references },
		RenderMarkdownCodeInline = { bg = c.references },

    -- tamago324/lir.nvim
    LirDir          = { fg = c.blue },
    LirEmptyDirText = { bg = c.highlight },
    CursorLineLir   = { bg = c.highlight },

    -- folke/noice.nvim
    NoiceCmdlinePopup = { bg = c.background_darker },
    NoiceMini         = { bg = c.background_darker },

    -- L3MON4D3/LuaSnip
    LuasnipChoice = { fg = c.orange },
    LuasnipInsert = { fg = c.cyan },
  }

  M.highlights = vim.tbl_deep_extend('force', default_highlights, overrides or {})
end

-- Lsp Semantics Tokens
local links = {
  ['@lsp.type.namespace'] = '@namespace',
  ['@lsp.type.type'] = '@type',
  ['@lsp.type.class'] = '@type',
  ['@lsp.type.enum'] = '@type',
  ['@lsp.type.interface'] = '@type',
  ['@lsp.type.struct'] = '@structure',
  ['@lsp.type.parameter'] = '@variable.parameter',
  ['@lsp.type.variable'] = '@variable',
  ['@lsp.type.property'] = '@property',
  ['@lsp.type.enumMember'] = '@constant',
  ['@lsp.type.function'] = '@function',
  ['@lsp.type.method'] = '@method',
  ['@lsp.type.macro'] = '@macro',
  ['@lsp.type.decorator'] = '@function',
}
for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

---@class PalenightfallOpts
---@field color_overrides table<string, string>
---@field highlight_overrides PalenightfallHighlightConfig
---@field transparent boolean

---Configure and enable the colorscheme.
--
---@param opts PalenightfallOpts
function M.setup(opts)
  opts = opts or {}

  if vim.g.colors_name then
    vim.cmd [[hi clear]]
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'palenightfall'

  if opts.color_overrides ~= nil then
    M.configure_colors(opts.color_overrides or {})
  end
  M.configure_highlights(opts.highlight_overrides or {}, opts.transparent)

  for group, hls in pairs(M.highlights) do
    highlight(group, hls)
  end
end

return M
