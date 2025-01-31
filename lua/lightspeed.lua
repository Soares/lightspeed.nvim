local api = vim.api
local function inc(x)
  return (x + 1)
end
local function dec(x)
  return (x - 1)
end
local function clamp(val, min, max)
  if (val < min) then
    return min
  elseif (val > max) then
    return max
  elseif "else" then
    return val
  end
end
local function last(tbl)
  return tbl[#tbl]
end
local empty_3f = vim.tbl_isempty
local function reverse_lookup(tbl)
  local tbl_9_auto = {}
  for k, v in ipairs(tbl) do
    local _2_, _3_ = v, k
    if ((nil ~= _2_) and (nil ~= _3_)) then
      local k_10_auto = _2_
      local v_11_auto = _3_
      tbl_9_auto[k_10_auto] = v_11_auto
    end
  end
  return tbl_9_auto
end
local function getchar_as_str()
  local ok_3f, ch = pcall(vim.fn.getchar)
  local function _5_()
    if (type(ch) == "number") then
      return vim.fn.nr2char(ch)
    else
      return ch
    end
  end
  return ok_3f, _5_()
end
local function replace_keycodes(s)
  return api.nvim_replace_termcodes(s, true, false, true)
end
local function echo(msg)
  vim.cmd("redraw")
  return api.nvim_echo({{msg}}, false, {})
end
local function operator_pending_mode_3f()
  return string.match(api.nvim_get_mode().mode, "o")
end
local function yank_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator == "y"))
end
local function change_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator == "c"))
end
local function delete_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator == "d"))
end
local function dot_repeatable_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator ~= "y"))
end
local function get_cursor_pos()
  return {vim.fn.line("."), vim.fn.col(".")}
end
local function char_at_pos(_6_, _8_)
  local _arg_7_ = _6_
  local line = _arg_7_[1]
  local byte_col = _arg_7_[2]
  local _arg_9_ = _8_
  local char_offset = _arg_9_["char-offset"]
  local line_str = vim.fn.getline(line)
  local char_idx = vim.fn.charidx(line_str, dec(byte_col))
  local char_nr = vim.fn.strgetchar(line_str, (char_idx + (char_offset or 0)))
  if (char_nr ~= -1) then
    return vim.fn.nr2char(char_nr)
  end
end
local function leftmost_editable_wincol()
  local view = vim.fn.winsaveview()
  vim.cmd("norm! 0")
  local wincol = vim.fn.wincol()
  vim.fn.winrestview(view)
  return wincol
end
local opts = {cycle_group_bwd_key = nil, cycle_group_fwd_key = nil, grey_out_search_area = true, highlight_unique_chars = false, instant_repeat_bwd_key = nil, instant_repeat_fwd_key = nil, jump_on_partial_input_safety_timeout = 400, jump_to_first_match = true, labels = nil, limit_ft_matches = 5, match_only_the_start_of_same_char_seqs = true, substitute_chars = {["\13"] = "\194\172"}, x_mode_prefix_key = "<c-x>"}
local function setup(user_opts)
  opts = setmetatable(user_opts, {__index = opts})
  return nil
end
local hl
local function _11_(self, hl_group, line, startcol, endcol)
  return api.nvim_buf_add_highlight(0, self.ns, hl_group, line, startcol, endcol)
end
local function _12_(self, line, col, opts0)
  return api.nvim_buf_set_extmark(0, self.ns, line, col, opts0)
end
local function _13_(self)
  return api.nvim_buf_clear_namespace(0, self.ns, 0, -1)
end
hl = {["add-hl"] = _11_, ["set-extmark"] = _12_, cleanup = _13_, group = {["label-distant"] = "LightspeedLabelDistant", ["label-distant-overlapped"] = "LightspeedLabelDistantOverlapped", ["label-overlapped"] = "LightspeedLabelOverlapped", ["masked-ch"] = "LightspeedMaskedChar", ["one-char-match"] = "LightspeedOneCharMatch", ["pending-change-op-area"] = "LightspeedPendingChangeOpArea", ["pending-op-area"] = "LightspeedPendingOpArea", ["shortcut-overlapped"] = "LightspeedShortcutOverlapped", ["unique-ch"] = "LightspeedUniqueChar", ["unlabeled-match"] = "LightspeedUnlabeledMatch", cursor = "LightspeedCursor", greywash = "LightspeedGreyWash", label = "LightspeedLabel", shortcut = "LightspeedShortcut"}, ns = api.nvim_create_namespace("")}
local function init_highlight()
  local bg = vim.o.background
  local groupdefs
  local _15_
  do
    local _14_ = bg
    if (_14_ == "light") then
      _15_ = "#f02077"
    else
      local _ = _14_
      _15_ = "#ff2f87"
    end
  end
  local _20_
  do
    local _19_ = bg
    if (_19_ == "light") then
      _20_ = "#ff4090"
    else
      local _ = _19_
      _20_ = "#e01067"
    end
  end
  local _25_
  do
    local _24_ = bg
    if (_24_ == "light") then
      _25_ = "Blue"
    else
      local _ = _24_
      _25_ = "Cyan"
    end
  end
  local _30_
  do
    local _29_ = bg
    if (_29_ == "light") then
      _30_ = "#399d9f"
    else
      local _ = _29_
      _30_ = "#99ddff"
    end
  end
  local _35_
  do
    local _34_ = bg
    if (_34_ == "light") then
      _35_ = "Cyan"
    else
      local _ = _34_
      _35_ = "Blue"
    end
  end
  local _40_
  do
    local _39_ = bg
    if (_39_ == "light") then
      _40_ = "#59bdbf"
    else
      local _ = _39_
      _40_ = "#79bddf"
    end
  end
  local _45_
  do
    local _44_ = bg
    if (_44_ == "light") then
      _45_ = "#cc9999"
    else
      local _ = _44_
      _45_ = "#b38080"
    end
  end
  local _50_
  do
    local _49_ = bg
    if (_49_ == "light") then
      _50_ = "Black"
    else
      local _ = _49_
      _50_ = "White"
    end
  end
  local _55_
  do
    local _54_ = bg
    if (_54_ == "light") then
      _55_ = "#272020"
    else
      local _ = _54_
      _55_ = "#f3ecec"
    end
  end
  local _60_
  do
    local _59_ = bg
    if (_59_ == "light") then
      _60_ = "#f02077"
    else
      local _ = _59_
      _60_ = "#ff2f87"
    end
  end
  groupdefs = {{hl.group.label, {cterm = "bold,underline", ctermfg = "Red", gui = "bold,underline", guifg = _15_}}, {hl.group["label-overlapped"], {cterm = "underline", ctermfg = "Magenta", gui = "underline", guifg = _20_}}, {hl.group["label-distant"], {cterm = "bold,underline", ctermfg = _25_, gui = "bold,underline", guifg = _30_}}, {hl.group["label-distant-overlapped"], {cterm = "underline", ctermfg = _35_, gui = "underline", guifg = _40_}}, {hl.group.shortcut, {cterm = "bold,underline", ctermbg = "Red", ctermfg = "White", gui = "bold,underline", guibg = "#f00077", guifg = "#ffffff"}}, {hl.group["one-char-match"], {cterm = "bold", ctermbg = "Red", ctermfg = "White", gui = "bold", guibg = "#f00077", guifg = "#ffffff"}}, {hl.group["masked-ch"], {ctermfg = "DarkGrey", guifg = _45_}}, {hl.group["unlabeled-match"], {cterm = "bold", ctermfg = _50_, gui = "bold", guifg = _55_}}, {hl.group["pending-op-area"], {ctermbg = "Red", ctermfg = "White", guibg = "#f00077", guifg = "#ffffff"}}, {hl.group["pending-change-op-area"], {cterm = "strikethrough", ctermfg = "Red", gui = "strikethrough", guifg = _60_}}, {hl.group.greywash, {ctermfg = "Grey", guifg = "#777777"}}}
  for _, _64_ in ipairs(groupdefs) do
    local _each_65_ = _64_
    local group = _each_65_[1]
    local attrs = _each_65_[2]
    local attrs_str
    local _66_
    do
      local tbl_12_auto = {}
      for k, v in pairs(attrs) do
        tbl_12_auto[(#tbl_12_auto + 1)] = (k .. "=" .. v)
      end
      _66_ = tbl_12_auto
    end
    attrs_str = table.concat(_66_, " ")
    vim.cmd(("highlight default " .. group .. " " .. attrs_str))
  end
  for _, _67_ in ipairs({{hl.group["unique-ch"], hl.group["unlabeled-match"]}, {hl.group["shortcut-overlapped"], hl.group.shortcut}, {hl.group.cursor, "Cursor"}}) do
    local _each_68_ = _67_
    local from_group = _each_68_[1]
    local to_group = _each_68_[2]
    vim.cmd(("highlight default link " .. from_group .. " " .. to_group))
  end
  return nil
end
init_highlight()
local function add_highlight_autocmds()
  vim.cmd("augroup LightspeedInitHighlight")
  vim.cmd("autocmd!")
  vim.cmd("autocmd ColorScheme * lua require'lightspeed'.init_highlight()")
  return vim.cmd("augroup end")
end
add_highlight_autocmds()
local function grey_out_search_area(reverse_3f)
  local _let_69_ = vim.tbl_map(dec, get_cursor_pos())
  local curline = _let_69_[1]
  local curcol = _let_69_[2]
  local _let_70_ = {dec(vim.fn.line("w0")), dec(vim.fn.line("w$"))}
  local win_top = _let_70_[1]
  local win_bot = _let_70_[2]
  local function _72_()
    if reverse_3f then
      return {{win_top, 0}, {curline, curcol}}
    else
      return {{curline, inc(curcol)}, {win_bot, -1}}
    end
  end
  local _let_71_ = _72_()
  local start = _let_71_[1]
  local finish = _let_71_[2]
  return vim.highlight.range(0, hl.ns, hl.group.greywash, start, finish)
end
local function echo_no_prev_search()
  return echo("no previous search")
end
local function echo_not_found(s)
  return echo(("not found: " .. s))
end
local function push_cursor_21(direction)
  local _74_
  do
    local _73_ = direction
    if (_73_ == "fwd") then
      _74_ = "W"
    elseif (_73_ == "bwd") then
      _74_ = "bW"
    else
    _74_ = nil
    end
  end
  return vim.fn.search("\\_.", _74_, __fnl_global___3fstopline)
end
local function cursor_before_eof_3f()
  return ((vim.fn.line(".") == vim.fn.line("$")) and (vim.fn.virtcol(".") == dec(vim.fn.virtcol("$"))))
end
local function force_matchparen_refresh()
  vim.cmd("silent! doautocmd matchparen CursorMoved")
  return vim.cmd("silent! doautocmd matchup_matchparen CursorMoved")
end
local function onscreen_match_positions(pattern, reverse_3f, _78_)
  local _arg_79_ = _78_
  local ft_search_3f = _arg_79_["ft-search?"]
  local limit = _arg_79_["limit"]
  local view = vim.fn.winsaveview()
  local cpo = vim.o.cpo
  local opts0
  if reverse_3f then
    opts0 = "b"
  else
    opts0 = ""
  end
  local stopline
  local function _81_()
    if reverse_3f then
      return "w0"
    else
      return "w$"
    end
  end
  stopline = vim.fn.line(_81_())
  local cleanup
  local function _82_()
    vim.fn.winrestview(view)
    vim.o.cpo = cpo
    return nil
  end
  cleanup = _82_
  local non_editable_width = dec(leftmost_editable_wincol())
  local col_in_edit_area = (vim.fn.wincol() - non_editable_width)
  local left_bound = (vim.fn.col(".") - dec(col_in_edit_area))
  local window_width = api.nvim_win_get_width(0)
  local right_bound = (left_bound + dec((window_width - non_editable_width - 1)))
  local function skip_to_fold_edge_21()
    local _83_
    local _84_
    if reverse_3f then
      _84_ = vim.fn.foldclosed
    else
      _84_ = vim.fn.foldclosedend
    end
    _83_ = _84_(vim.fn.line("."))
    if (_83_ == -1) then
      return "not-in-fold"
    elseif (nil ~= _83_) then
      local fold_edge = _83_
      vim.fn.cursor(fold_edge, 0)
      local function _86_()
        if reverse_3f then
          return 1
        else
          return vim.fn.col("$")
        end
      end
      vim.fn.cursor(0, _86_())
      return "moved-the-cursor"
    end
  end
  local function skip_to_next_onscreen_pos_21()
    local _local_88_ = get_cursor_pos()
    local line = _local_88_[1]
    local col = _local_88_[2]
    local from_pos = _local_88_
    local _89_
    if (col < left_bound) then
      if reverse_3f then
        if (dec(line) >= stopline) then
          _89_ = {dec(line), right_bound}
        else
        _89_ = nil
        end
      else
        _89_ = {line, left_bound}
      end
    elseif (col > right_bound) then
      if reverse_3f then
        _89_ = {line, right_bound}
      else
        if (inc(line) <= stopline) then
          _89_ = {inc(line), left_bound}
        else
        _89_ = nil
        end
      end
    else
    _89_ = nil
    end
    if (nil ~= _89_) then
      local to_pos = _89_
      if (from_pos ~= to_pos) then
        vim.fn.cursor(to_pos)
        return "moved-the-cursor"
      end
    end
  end
  vim.o.cpo = cpo:gsub("c", "")
  local match_count = 0
  local function rec(match_at_curpos_3f)
    if (limit and (match_count >= limit)) then
      return cleanup()
    else
      local _97_
      local _98_
      if match_at_curpos_3f then
        _98_ = "c"
      else
        _98_ = ""
      end
      _97_ = vim.fn.searchpos(pattern, (opts0 .. _98_), stopline)
      if ((type(_97_) == "table") and ((_97_)[1] == 0) and true) then
        local _ = (_97_)[2]
        return cleanup()
      elseif ((type(_97_) == "table") and (nil ~= (_97_)[1]) and (nil ~= (_97_)[2])) then
        local line = (_97_)[1]
        local col = (_97_)[2]
        local pos = _97_
        if ft_search_3f then
          match_count = (match_count + 1)
          return pos
        else
          local _100_ = skip_to_fold_edge_21()
          if (_100_ == "moved-the-cursor") then
            return rec(false)
          elseif (_100_ == "not-in-fold") then
            if (vim.wo.wrap or (function(_101_,_102_,_103_) return (_101_ <= _102_) and (_102_ <= _103_) end)(left_bound,col,right_bound)) then
              match_count = (match_count + 1)
              return pos
            else
              local _104_ = skip_to_next_onscreen_pos_21()
              if (_104_ == "moved-the-cursor") then
                return rec(true)
              else
                local _ = _104_
                return cleanup()
              end
            end
          end
        end
      end
    end
  end
  return rec
end
local function highlight_unique_chars(reverse_3f, ignorecase)
  local unique_chars = {}
  for pos in onscreen_match_positions("..", reverse_3f, {}) do
    local ch = char_at_pos(pos, {})
    local _112_
    do
      local _111_ = unique_chars[ch]
      if (_111_ == nil) then
        _112_ = pos
      else
        local _ = _111_
        _112_ = false
      end
    end
    unique_chars[ch] = _112_
  end
  for ch, pos_or_false in pairs(unique_chars) do
    if pos_or_false then
      local _let_116_ = pos_or_false
      local line = _let_116_[1]
      local col = _let_116_[2]
      hl["set-extmark"](hl, dec(line), dec(col), {virt_text = {{ch, hl.group["unique-ch"]}}, virt_text_pos = "overlay"})
    end
  end
  return nil
end
local function highlight_cursor(_3fpos)
  local _let_118_ = (_3fpos or get_cursor_pos())
  local line = _let_118_[1]
  local col = _let_118_[2]
  local pos = _let_118_
  local ch_at_curpos = (char_at_pos(pos, {}) or " ")
  return hl["set-extmark"](hl, dec(line), dec(col), {hl_mode = "combine", virt_text = {{ch_at_curpos, hl.group.cursor}}, virt_text_pos = "overlay"})
end
local function handle_interrupted_change_op_21()
  echo("")
  local curcol = vim.fn.col(".")
  local endcol = vim.fn.col("$")
  local _3fright
  if (not vim.o.insertmode and (curcol > 1) and (curcol < endcol)) then
    _3fright = "<RIGHT>"
  else
    _3fright = ""
  end
  return api.nvim_feedkeys(replace_keycodes(("<C-\\><C-G>" .. _3fright)), "n", true)
end
local function get_input_and_clean_up()
  local ok_3f, res = getchar_as_str()
  hl:cleanup()
  if (ok_3f and (res ~= replace_keycodes("<esc>"))) then
    return res
  end
end
local function set_dot_repeat(cmd, _3fcount)
  if operator_pending_mode_3f() then
    local op = vim.v.operator
    if (op ~= "y") then
      local change
      if (op == "c") then
        change = replace_keycodes("<c-r>.<esc>")
      else
      change = nil
      end
      local seq = (op .. (_3fcount or "") .. cmd .. (change or ""))
      pcall(vim.fn["repeat#setreg"], seq, vim.v.register)
      return pcall(vim.fn["repeat#set"], seq, -1)
    end
  end
end
local ft = {["instant-repeat?"] = nil, ["prev-dot-repeatable-search"] = nil, ["prev-reverse?"] = nil, ["prev-search"] = nil, ["prev-t-like?"] = nil, ["started-reverse?"] = nil, stack = {}}
ft.to = function(self, reverse_3f, t_like_3f, dot_repeat_3f, revert_3f)
  local _
  if not self["instant-repeat?"] then
    self["started-reverse?"] = reverse_3f
    _ = nil
  else
  _ = nil
  end
  local reverse_3f0
  if self["instant-repeat?"] then
    reverse_3f0 = ((not reverse_3f and self["started-reverse?"]) or (reverse_3f and not self["started-reverse?"]))
  else
    reverse_3f0 = reverse_3f
  end
  local switched_directions_3f = ((reverse_3f0 and not self["prev-reverse?"]) or (not reverse_3f0 and self["prev-reverse?"]))
  local count
  if self["instant-repeat?"] then
    if revert_3f then
      if t_like_3f then
        count = 1
      else
        count = 0
      end
    else
      if (t_like_3f and not switched_directions_3f) then
        count = inc(vim.v.count1)
      else
        count = vim.v.count1
      end
    end
  else
    count = vim.v.count1
  end
  local _let_130_ = vim.tbl_map(replace_keycodes, {opts.instant_repeat_fwd_key, opts.instant_repeat_bwd_key})
  local repeat_key = _let_130_[1]
  local revert_key = _let_130_[2]
  local op_mode_3f = operator_pending_mode_3f()
  local dot_repeatable_op_3f = dot_repeatable_operation_3f()
  local motion
  if (not t_like_3f and not reverse_3f0) then
    motion = "f"
  elseif (not t_like_3f and reverse_3f0) then
    motion = "F"
  elseif (t_like_3f and not reverse_3f0) then
    motion = "t"
  elseif (t_like_3f and reverse_3f0) then
    motion = "T"
  else
  motion = nil
  end
  local cmd_for_dot_repeat = (replace_keycodes("<Plug>Lightspeed_dotrepeat_") .. motion)
  if not (dot_repeat_3f or self["instant-repeat?"]) then
    if vim.fn.exists("#User#LightspeedEnter") then
      vim.cmd("doautocmd <nomodeline> User LightspeedEnter")
    end
    echo("")
    highlight_cursor()
    vim.cmd("redraw")
  end
  local enter_repeat_3f = nil
  local _134_
  if self["instant-repeat?"] then
    _134_ = self["prev-search"]
  elseif dot_repeat_3f then
    _134_ = self["prev-dot-repeatable-search"]
  else
    local _135_
    local function _136_()
      if change_operation_3f() then
        handle_interrupted_change_op_21()
      end
      do
      end
      do
      end
      if vim.fn.exists("#User#LightspeedLeave") then
        vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
      end
      return nil
    end
    _135_ = (get_input_and_clean_up() or _136_())
    if (_135_ == "\13") then
      enter_repeat_3f = true
      local function _139_()
        if change_operation_3f() then
          handle_interrupted_change_op_21()
        end
        do
          echo_no_prev_search()
        end
        do
        end
        if vim.fn.exists("#User#LightspeedLeave") then
          vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
        end
        return nil
      end
      _134_ = (self["prev-search"] or _139_())
    elseif (nil ~= _135_) then
      local _in = _135_
      _134_ = _in
    else
    _134_ = nil
    end
  end
  if (nil ~= _134_) then
    local in1 = _134_
    local new_search_3f = not (enter_repeat_3f or self["instant-repeat?"] or dot_repeat_3f)
    if new_search_3f then
      if dot_repeatable_op_3f then
        self["prev-dot-repeatable-search"] = in1
        set_dot_repeat(cmd_for_dot_repeat, count)
      else
        self["prev-search"] = in1
      end
    end
    self["prev-reverse?"] = reverse_3f0
    self["prev-t-like?"] = t_like_3f
    local i = 0
    local match_pos = nil
    local function _148_()
      local pattern = ("\\V" .. in1:gsub("\\", "\\\\"))
      local limit
      if opts.limit_ft_matches then
        limit = (count + opts.limit_ft_matches)
      else
      limit = nil
      end
      return onscreen_match_positions(pattern, reverse_3f0, {["ft-search?"] = true, limit = limit})
    end
    for _146_ in _148_() do
      local _each_149_ = _146_
      local line = _each_149_[1]
      local col = _each_149_[2]
      local pos = _each_149_
      i = (i + 1)
      if (i <= count) then
        match_pos = pos
      else
        if not op_mode_3f then
          hl["add-hl"](hl, hl.group["one-char-match"], dec(line), dec(col), col)
        end
      end
    end
    if (i == 0) then
      if change_operation_3f() then
        handle_interrupted_change_op_21()
      end
      do
        echo_not_found(in1)
      end
      do
      end
      if vim.fn.exists("#User#LightspeedLeave") then
        vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
      end
      return nil
    else
      if not revert_3f then
        local op_mode_3f_4_auto = operator_pending_mode_3f()
        local restore_virtualedit_autocmd_5_auto = ("autocmd CursorMoved,WinLeave,BufLeave" .. ",InsertEnter,CmdlineEnter,CmdwinEnter" .. " * ++once set virtualedit=" .. vim.o.virtualedit)
        if not self["instant-repeat?"] then
          vim.cmd("norm! m`")
        end
        vim.fn.cursor(match_pos)
        if t_like_3f then
          local function _155_()
            if reverse_3f0 then
              return "fwd"
            else
              return "bwd"
            end
          end
          push_cursor_21(_155_())
        end
        if (op_mode_3f_4_auto and not reverse_3f0 and true) then
          local _157_ = string.sub(vim.fn.mode("t"), -1)
          if (_157_ == "v") then
            push_cursor_21("bwd")
          elseif (_157_ == "o") then
            if not cursor_before_eof_3f() then
              push_cursor_21("fwd")
            else
              vim.cmd("set virtualedit=onemore")
              vim.cmd("norm! l")
              vim.cmd(restore_virtualedit_autocmd_5_auto)
            end
          end
        end
        if not op_mode_3f_4_auto then
          force_matchparen_refresh()
        end
      end
      local new_pos = get_cursor_pos()
      if not op_mode_3f then
        highlight_cursor()
        vim.cmd("redraw")
        local ok_3f, in2 = getchar_as_str()
        local mode
        if (vim.fn.mode() == "n") then
          mode = "n"
        else
          mode = "x"
        end
        local repeat_3f
        local _164_
        if t_like_3f then
          _164_ = "t"
        else
          _164_ = "f"
        end
        repeat_3f = ((in2 == repeat_key) or string.match(vim.fn.maparg(in2, mode), ("<Plug>Lightspeed_" .. _164_)))
        local revert_3f0
        local _166_
        if t_like_3f then
          _166_ = "T"
        else
          _166_ = "F"
        end
        revert_3f0 = ((in2 == revert_key) or string.match(vim.fn.maparg(in2, mode), ("<Plug>Lightspeed_" .. _166_)))
        hl:cleanup()
        self["instant-repeat?"] = (ok_3f and (repeat_3f or revert_3f0))
        if not self["instant-repeat?"] then
          do
            self.stack = {}
            local _168_
            if ok_3f then
              _168_ = in2
            else
              _168_ = replace_keycodes("<esc>")
            end
            vim.fn.feedkeys(_168_, "i")
          end
          if vim.fn.exists("#User#LightspeedLeave") then
            vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
          end
          return nil
        else
          if revert_3f0 then
            local _171_ = table.remove(self.stack)
            if (nil ~= _171_) then
              local prev_pos = _171_
              vim.fn.cursor(prev_pos)
            end
          else
            table.insert(self.stack, new_pos)
          end
          return ft:to(false, t_like_3f, false, revert_3f0)
        end
      end
    end
  end
end
local function get_labels()
  local function _178_()
    if opts.jump_to_first_match then
      return {"s", "f", "n", "/", "u", "t", "q", "S", "F", "G", "H", "L", "M", "N", "?", "U", "R", "Z", "T", "Q"}
    else
      return {"f", "j", "d", "k", "s", "l", "a", ";", "e", "i", "w", "o", "g", "h", "v", "n", "c", "m", "z", "."}
    end
  end
  return (opts.labels or _178_())
end
local function get_cycle_keys()
  local function _179_()
    if opts.jump_to_first_match then
      return "<tab>"
    else
      return "<space>"
    end
  end
  local function _180_()
    if opts.jump_to_first_match then
      return "<s-tab>"
    else
      return "<tab>"
    end
  end
  return vim.tbl_map(replace_keycodes, {(opts.cycle_group_fwd_key or _179_()), (opts.cycle_group_bwd_key or _180_())})
end
local function get_match_map_for(ch1, reverse_3f)
  local match_map = {}
  local prefix = "\\V\\C"
  local input = ch1:gsub("\\", "\\\\")
  local pattern = (prefix .. input .. "\\_.")
  local match_count = 0
  local prev = {}
  for _181_ in onscreen_match_positions(pattern, reverse_3f, {}) do
    local _each_182_ = _181_
    local line = _each_182_[1]
    local col = _each_182_[2]
    local pos = _each_182_
    local overlap_with_prev_3f
    local _183_
    if reverse_3f then
      _183_ = dec
    else
      _183_ = inc
    end
    overlap_with_prev_3f = ((line == prev.line) and (col == _183_(prev.col)))
    local ch2 = (char_at_pos(pos, {["char-offset"] = 1}) or "\13")
    local same_pair_3f = (ch2 == prev.ch2)
    local function _185_()
      if not opts.match_only_the_start_of_same_char_seqs then
        return prev["skipped?"]
      end
    end
    if (_185_() or not (overlap_with_prev_3f and same_pair_3f)) then
      local partially_covered_3f = (overlap_with_prev_3f and not reverse_3f)
      if not match_map[ch2] then
        match_map[ch2] = {}
      end
      table.insert(match_map[ch2], {line, col, partially_covered_3f, __fnl_global___3fch3})
      if (overlap_with_prev_3f and reverse_3f) then
        last(match_map[prev.ch2])[3] = true
      end
      prev = {["skipped?"] = false, ch2 = ch2, col = col, line = line}
      match_count = (match_count + 1)
    else
      prev = {["skipped?"] = true, ch2 = ch2, col = col, line = line}
    end
  end
  local _189_ = match_count
  if (_189_ == 0) then
    return nil
  elseif (_189_ == 1) then
    local ch2 = vim.tbl_keys(match_map)[1]
    local pos = vim.tbl_values(match_map)[1][1]
    return {ch2, pos}
  else
    local _ = _189_
    return match_map
  end
end
local function set_beacon_at(_191_, ch1, ch2, _193_)
  local _arg_192_ = _191_
  local line = _arg_192_[1]
  local col = _arg_192_[2]
  local partially_covered_3f = _arg_192_[3]
  local pos = _arg_192_
  local _arg_194_ = _193_
  local distant_3f = _arg_194_["distant?"]
  local init_round_3f = _arg_194_["init-round?"]
  local labeled_3f = _arg_194_["labeled?"]
  local repeat_3f = _arg_194_["repeat?"]
  local shortcut_3f = _arg_194_["shortcut?"]
  local ch10 = (opts.substitute_chars[ch1] or ch1)
  local ch20
  local function _195_()
    if not labeled_3f then
      return opts.substitute_chars[ch2]
    end
  end
  ch20 = (_195_() or ch2)
  local partially_covered_3f0
  if not repeat_3f then
    partially_covered_3f0 = partially_covered_3f
  else
  partially_covered_3f0 = nil
  end
  local shortcut_3f0
  if not repeat_3f then
    shortcut_3f0 = shortcut_3f
  else
  shortcut_3f0 = nil
  end
  local label_hl
  if shortcut_3f0 then
    label_hl = hl.group.shortcut
  elseif distant_3f then
    label_hl = hl.group["label-distant"]
  else
    label_hl = hl.group.label
  end
  local overlapped_label_hl
  if shortcut_3f0 then
    overlapped_label_hl = hl.group["shortcut-overlapped"]
  elseif distant_3f then
    overlapped_label_hl = hl.group["label-distant-overlapped"]
  else
    overlapped_label_hl = hl.group["label-overlapped"]
  end
  local function _203_()
    if not labeled_3f then
      if partially_covered_3f0 then
        return {inc(col), {ch20, hl.group["unlabeled-match"]}, nil}
      else
        return {col, {ch10, hl.group["unlabeled-match"]}, {ch20, hl.group["unlabeled-match"]}}
      end
    elseif partially_covered_3f0 then
      if init_round_3f then
        return {inc(col), {ch20, overlapped_label_hl}, nil}
      else
        return {col, {ch10, hl.group["masked-ch"]}, {ch20, overlapped_label_hl}}
      end
    elseif repeat_3f then
      return {inc(col), {ch20, label_hl}, nil}
    else
      return {col, {ch10, hl.group["masked-ch"]}, {ch20, label_hl}}
    end
  end
  local _let_200_ = _203_()
  local startcol = _let_200_[1]
  local chunk1 = _let_200_[2]
  local _3fchunk2 = _let_200_[3]
  return hl["set-extmark"](hl, dec(line), dec(startcol), {virt_text = {chunk1, _3fchunk2}, virt_text_pos = "overlay"})
end
local function set_beacon_groups(ch2, positions, labels, shortcuts, _204_)
  local _arg_205_ = _204_
  local group_offset = _arg_205_["group-offset"]
  local init_round_3f = _arg_205_["init-round?"]
  local repeat_3f = _arg_205_["repeat?"]
  local group_offset0 = (group_offset or 0)
  local _7clabels_7c = #labels
  local set_group
  local function _206_(start, distant_3f)
    for i = start, dec((start + _7clabels_7c)) do
      if ((i < 1) or (i > #positions)) then break end
      local pos = positions[i]
      local label = (labels[(i % _7clabels_7c)] or labels[_7clabels_7c])
      local shortcut_3f
      if not distant_3f then
        shortcut_3f = shortcuts[pos]
      else
      shortcut_3f = nil
      end
      set_beacon_at(pos, ch2, label, {["distant?"] = distant_3f, ["init-round?"] = init_round_3f, ["labeled?"] = true, ["repeat?"] = repeat_3f, ["shortcut?"] = shortcut_3f})
    end
    return nil
  end
  set_group = _206_
  local start = inc((group_offset0 * _7clabels_7c))
  local _end = dec((start + _7clabels_7c))
  set_group(start, false)
  return set_group((start + _7clabels_7c), true)
end
local function get_shortcuts(match_map, labels, reverse_3f, jump_to_first_3f)
  local collides_with_a_ch2_3f
  local function _208_(_241)
    return vim.tbl_contains(vim.tbl_keys(match_map), _241)
  end
  collides_with_a_ch2_3f = _208_
  local by_distance_from_cursor
  local function _215_(_209_, _212_)
    local _arg_210_ = _209_
    local _arg_211_ = _arg_210_[1]
    local l1 = _arg_211_[1]
    local c1 = _arg_211_[2]
    local _ = _arg_210_[2]
    local _0 = _arg_210_[3]
    local _arg_213_ = _212_
    local _arg_214_ = _arg_213_[1]
    local l2 = _arg_214_[1]
    local c2 = _arg_214_[2]
    local _1 = _arg_213_[2]
    local _2 = _arg_213_[3]
    if (l1 == l2) then
      if reverse_3f then
        return (c1 > c2)
      else
        return (c1 < c2)
      end
    else
      if reverse_3f then
        return (l1 > l2)
      else
        return (l1 < l2)
      end
    end
  end
  by_distance_from_cursor = _215_
  local shortcuts = {}
  for ch2, positions in pairs(match_map) do
    for i, pos in ipairs(positions) do
      local labeled_pos_3f = not ((#positions == 1) or (jump_to_first_3f and (i == 1)))
      if labeled_pos_3f then
        local _219_
        local _220_
        if jump_to_first_3f then
          _220_ = dec(i)
        else
          _220_ = i
        end
        _219_ = labels[_220_]
        if (nil ~= _219_) then
          local label = _219_
          if not collides_with_a_ch2_3f(label) then
            table.insert(shortcuts, {pos, label, ch2})
          end
        end
      end
    end
  end
  table.sort(shortcuts, by_distance_from_cursor)
  local lookup_by_pos
  do
    local labels_used_up = {}
    local tbl_9_auto = {}
    for _, _225_ in ipairs(shortcuts) do
      local _each_226_ = _225_
      local pos = _each_226_[1]
      local label = _each_226_[2]
      local ch2 = _each_226_[3]
      local _227_, _228_ = nil, nil
      if not labels_used_up[label] then
        labels_used_up[label] = true
        _227_, _228_ = pos, {label, ch2}
      else
      _227_, _228_ = nil
      end
      if ((nil ~= _227_) and (nil ~= _228_)) then
        local k_10_auto = _227_
        local v_11_auto = _228_
        tbl_9_auto[k_10_auto] = v_11_auto
      end
    end
    lookup_by_pos = tbl_9_auto
  end
  local lookup_by_label
  do
    local tbl_9_auto = {}
    for pos, _231_ in pairs(lookup_by_pos) do
      local _each_232_ = _231_
      local label = _each_232_[1]
      local ch2 = _each_232_[2]
      local _233_, _234_ = label, {pos, ch2}
      if ((nil ~= _233_) and (nil ~= _234_)) then
        local k_10_auto = _233_
        local v_11_auto = _234_
        tbl_9_auto[k_10_auto] = v_11_auto
      end
    end
    lookup_by_label = tbl_9_auto
  end
  return vim.tbl_extend("error", lookup_by_pos, lookup_by_label)
end
local function ignore_char_until_timeout(char_to_ignore)
  local start = os.clock()
  local timeout_secs = (opts.jump_on_partial_input_safety_timeout / 1000)
  local ok_3f, input = getchar_as_str()
  if not ((input == char_to_ignore) and (os.clock() < (start + timeout_secs))) then
    if ok_3f then
      return vim.fn.feedkeys(input, "i")
    end
  end
end
local s = {["prev-dot-repeatable-search"] = {["x-mode?"] = nil, in1 = nil, in2 = nil, in3 = nil}, ["prev-search"] = {in1 = nil, in2 = nil}}
s.to = function(self, reverse_3f, invoked_in_x_mode_3f, dot_repeat_3f)
  local op_mode_3f = operator_pending_mode_3f()
  local change_op_3f = change_operation_3f()
  local delete_op_3f = delete_operation_3f()
  local dot_repeatable_op_3f = dot_repeatable_operation_3f()
  local x_mode_prefix_key = replace_keycodes((opts.x_mode_prefix_key or opts.full_inclusive_prefix_key))
  local _let_238_ = get_cycle_keys()
  local cycle_fwd_key = _let_238_[1]
  local cycle_bwd_key = _let_238_[2]
  local labels = get_labels()
  local jump_to_first_3f = (opts.jump_to_first_match and not op_mode_3f)
  local cmd_for_dot_repeat
  local _239_
  if invoked_in_x_mode_3f then
    if reverse_3f then
      _239_ = "X"
    else
      _239_ = "x"
    end
  else
    if reverse_3f then
      _239_ = "S"
    else
      _239_ = "s"
    end
  end
  cmd_for_dot_repeat = replace_keycodes(("<Plug>Lightspeed_dotrepeat_" .. _239_))
  local enter_repeat_3f = nil
  local new_search_3f = nil
  local x_mode_3f = nil
  local restore_scrolloff_cmd = nil
  local function switch_off_scrolloff()
    if jump_to_first_3f then
      local _3floc
      if (api.nvim_eval("&l:scrolloff") ~= -1) then
        _3floc = "l:"
      else
        _3floc = ""
      end
      local saved_val = api.nvim_eval(("&" .. _3floc .. "scrolloff"))
      restore_scrolloff_cmd = ("let &" .. _3floc .. "scrolloff=" .. saved_val)
      return vim.cmd(("let &" .. _3floc .. "scrolloff=0"))
    end
  end
  local function restore_scrolloff()
    if jump_to_first_3f then
      return vim.cmd((restore_scrolloff_cmd or ""))
    end
  end
  local function cycle_through_match_groups(in2, positions_to_label, shortcuts, enter_repeat_3f0)
    local ret = nil
    local group_offset = 0
    local loop_3f = true
    while loop_3f do
      local _246_
      local function _247_()
        if dot_repeat_3f then
          return self["prev-dot-repeatable-search"].in3
        end
      end
      local function _248_()
        loop_3f = false
        ret = nil
        return nil
      end
      _246_ = (_247_() or get_input_and_clean_up() or _248_())
      if (nil ~= _246_) then
        local input = _246_
        if not ((input == cycle_fwd_key) or (input == cycle_bwd_key)) then
          loop_3f = false
          ret = {group_offset, input}
        else
          local max_offset = math.floor((#positions_to_label / #labels))
          local _250_
          do
            local _249_ = input
            if (_249_ == cycle_fwd_key) then
              _250_ = inc
            else
              local _ = _249_
              _250_ = dec
            end
          end
          group_offset = clamp(_250_(group_offset), 0, max_offset)
          if opts.grey_out_search_area then
            grey_out_search_area(reverse_3f)
          end
          do
            set_beacon_groups(in2, positions_to_label, labels, shortcuts, {["group-offset"] = group_offset, ["repeat?"] = enter_repeat_3f0})
          end
          highlight_cursor()
          vim.cmd("redraw")
        end
      end
    end
    return ret
  end
  local function save_state_for(_257_)
    local _arg_258_ = _257_
    local dot_repeat = _arg_258_["dot-repeat"]
    local enter_repeat = _arg_258_["enter-repeat"]
    if new_search_3f then
      if dot_repeatable_op_3f then
        if dot_repeat then
          dot_repeat["x-mode?"] = x_mode_3f
          self["prev-dot-repeatable-search"] = dot_repeat
          return nil
        end
      elseif enter_repeat then
        self["prev-search"] = enter_repeat
        return nil
      end
    end
  end
  local jump_with_wrap_21
  do
    local first_jump_3f = true
    local function _262_(target)
      do
        local op_mode_3f_4_auto = operator_pending_mode_3f()
        local restore_virtualedit_autocmd_5_auto = ("autocmd CursorMoved,WinLeave,BufLeave" .. ",InsertEnter,CmdlineEnter,CmdwinEnter" .. " * ++once set virtualedit=" .. vim.o.virtualedit)
        if first_jump_3f then
          vim.cmd("norm! m`")
        end
        vim.fn.cursor(target)
        if x_mode_3f then
          push_cursor_21("fwd")
          if reverse_3f then
            push_cursor_21("fwd")
          end
        end
        if (op_mode_3f_4_auto and not reverse_3f and (x_mode_3f and not reverse_3f)) then
          local _266_ = string.sub(vim.fn.mode("t"), -1)
          if (_266_ == "v") then
            push_cursor_21("bwd")
          elseif (_266_ == "o") then
            if not cursor_before_eof_3f() then
              push_cursor_21("fwd")
            else
              vim.cmd("set virtualedit=onemore")
              vim.cmd("norm! l")
              vim.cmd(restore_virtualedit_autocmd_5_auto)
            end
          end
        end
        if not op_mode_3f_4_auto then
          force_matchparen_refresh()
        end
      end
      if dot_repeatable_op_3f then
        set_dot_repeat(cmd_for_dot_repeat)
      end
      first_jump_3f = false
      return nil
    end
    jump_with_wrap_21 = _262_
  end
  local function jump_and_ignore_ch2_until_timeout_21(_272_, ch2)
    local _arg_273_ = _272_
    local target_line = _arg_273_[1]
    local target_col = _arg_273_[2]
    local _ = _arg_273_[3]
    local target_pos = _arg_273_
    local orig_pos = get_cursor_pos()
    jump_with_wrap_21(target_pos)
    if new_search_3f then
      local ctrl_v = replace_keycodes("<c-v>")
      local forward_x_3f = (x_mode_3f and not reverse_3f)
      local backward_x_3f = (x_mode_3f and reverse_3f)
      local forced_motion = string.sub(vim.fn.mode("t"), -1)
      local from_pos = vim.tbl_map(dec, orig_pos)
      local to_pos
      local function _274_()
        if backward_x_3f then
          return inc(inc(target_col))
        elseif forward_x_3f then
          return inc(target_col)
        else
          return target_col
        end
      end
      to_pos = vim.tbl_map(dec, {target_line, _274_()})
      local function _276_()
        if reverse_3f then
          return to_pos
        else
          return from_pos
        end
      end
      local _let_275_ = _276_()
      local startline = _let_275_[1]
      local startcol = _let_275_[2]
      local start = _let_275_
      local function _278_()
        if reverse_3f then
          return from_pos
        else
          return to_pos
        end
      end
      local _let_277_ = _278_()
      local endline = _let_277_[1]
      local endcol = _let_277_[2]
      local _end = _let_277_
      if not change_op_3f then
        local _3fpos_to_highlight_at
        if op_mode_3f then
          if (forced_motion == ctrl_v) then
            _3fpos_to_highlight_at = {inc(startline), inc(math.min(startcol, endcol))}
          elseif not reverse_3f then
            _3fpos_to_highlight_at = orig_pos
          else
          _3fpos_to_highlight_at = nil
          end
        else
        _3fpos_to_highlight_at = nil
        end
        highlight_cursor(_3fpos_to_highlight_at)
      end
      if op_mode_3f then
        local inclusive_motion_3f = forward_x_3f
        local hl_group
        if (change_op_3f or delete_op_3f) then
          hl_group = hl.group["pending-change-op-area"]
        else
          hl_group = hl.group["pending-op-area"]
        end
        local function hl_range(start0, _end0)
          return vim.highlight.range(0, hl.ns, hl_group, start0, _end0)
        end
        local _283_ = forced_motion
        if (_283_ == ctrl_v) then
          for line = startline, endline do
            hl_range({line, math.min(startcol, endcol)}, {line, inc(math.max(startcol, endcol))})
          end
        elseif (_283_ == "V") then
          hl_range({startline, 0}, {endline, -1})
        elseif (_283_ == "v") then
          local function _284_()
            if inclusive_motion_3f then
              return endcol
            else
              return inc(endcol)
            end
          end
          hl_range(start, {endline, _284_()})
        elseif (_283_ == "o") then
          local function _285_()
            if inclusive_motion_3f then
              return inc(endcol)
            else
              return endcol
            end
          end
          hl_range(start, {endline, _285_()})
        end
      end
      vim.cmd("redraw")
      ignore_char_until_timeout(ch2)
      if change_op_3f then
        echo("")
      end
      return hl:cleanup()
    end
  end
  if not dot_repeat_3f then
    if vim.fn.exists("#User#LightspeedEnter") then
      vim.cmd("doautocmd <nomodeline> User LightspeedEnter")
    end
    echo("")
    if opts.grey_out_search_area then
      grey_out_search_area(reverse_3f)
    end
    do
      if opts.highlight_unique_chars then
        highlight_unique_chars(reverse_3f)
      end
    end
    highlight_cursor()
    vim.cmd("redraw")
  end
  local _294_
  if dot_repeat_3f then
    x_mode_3f = self["prev-dot-repeatable-search"]["x-mode?"]
    _294_ = self["prev-dot-repeatable-search"].in1
  else
    local _295_
    local function _296_()
      if change_operation_3f() then
        handle_interrupted_change_op_21()
      end
      do
      end
      do
      end
      if vim.fn.exists("#User#LightspeedLeave") then
        vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
      end
      return nil
    end
    _295_ = (get_input_and_clean_up() or _296_())
    if (nil ~= _295_) then
      local in0 = _295_
      enter_repeat_3f = (in0 == "\13")
      new_search_3f = not (enter_repeat_3f or dot_repeat_3f)
      x_mode_3f = (invoked_in_x_mode_3f or (in0 == x_mode_prefix_key))
      if enter_repeat_3f then
        local function _299_()
          if change_operation_3f() then
            handle_interrupted_change_op_21()
          end
          do
            echo_no_prev_search()
          end
          do
          end
          if vim.fn.exists("#User#LightspeedLeave") then
            vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
          end
          return nil
        end
        _294_ = (self["prev-search"].in1 or _299_())
      elseif (x_mode_3f and not invoked_in_x_mode_3f) then
        local function _302_()
          if change_operation_3f() then
            handle_interrupted_change_op_21()
          end
          do
          end
          do
          end
          if vim.fn.exists("#User#LightspeedLeave") then
            vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
          end
          return nil
        end
        _294_ = (get_input_and_clean_up() or _302_())
      else
        _294_ = in0
      end
    else
    _294_ = nil
    end
  end
  if (nil ~= _294_) then
    local in1 = _294_
    local prev_in2
    if enter_repeat_3f then
      prev_in2 = self["prev-search"].in2
    elseif dot_repeat_3f then
      prev_in2 = self["prev-dot-repeatable-search"].in2
    else
    prev_in2 = nil
    end
    local _309_
    local function _310_()
      if change_operation_3f() then
        handle_interrupted_change_op_21()
      end
      do
        echo_not_found((in1 .. (prev_in2 or "")))
      end
      do
      end
      if vim.fn.exists("#User#LightspeedLeave") then
        vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
      end
      return nil
    end
    _309_ = (get_match_map_for(in1, reverse_3f) or _310_())
    if ((type(_309_) == "table") and (nil ~= (_309_)[1]) and (nil ~= (_309_)[2])) then
      local ch2 = (_309_)[1]
      local pos = (_309_)[2]
      local unique_match = _309_
      if (new_search_3f or (ch2 == prev_in2)) then
        do
          save_state_for({["dot-repeat"] = {in1 = in1, in2 = ch2, in3 = labels[1]}, ["enter-repeat"] = {in1 = in1, in2 = ch2}})
          jump_and_ignore_ch2_until_timeout_21(pos, ch2)
        end
        if vim.fn.exists("#User#LightspeedLeave") then
          vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
        end
        return nil
      else
        if change_operation_3f() then
          handle_interrupted_change_op_21()
        end
        do
          echo_not_found((in1 .. prev_in2))
        end
        do
        end
        if vim.fn.exists("#User#LightspeedLeave") then
          vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
        end
        return nil
      end
    elseif (nil ~= _309_) then
      local match_map = _309_
      local shortcuts = get_shortcuts(match_map, labels, reverse_3f, jump_to_first_3f)
      if new_search_3f then
        if opts.grey_out_search_area then
          grey_out_search_area(reverse_3f)
        end
        do
          for ch2, positions in pairs(match_map) do
            local _let_318_ = positions
            local first = _let_318_[1]
            local rest = {(table.unpack or unpack)(_let_318_, 2)}
            local positions_to_label
            if jump_to_first_3f then
              positions_to_label = rest
            else
              positions_to_label = positions
            end
            if (jump_to_first_3f or empty_3f(rest)) then
              set_beacon_at(first, in1, ch2, {["init-round?"] = true})
            end
            if not empty_3f(rest) then
              set_beacon_groups(ch2, positions_to_label, labels, shortcuts, {["init-round?"] = true})
            end
          end
        end
        highlight_cursor()
        vim.cmd("redraw")
      end
      local _323_
      local function _324_()
        if change_operation_3f() then
          handle_interrupted_change_op_21()
        end
        do
        end
        do
        end
        if vim.fn.exists("#User#LightspeedLeave") then
          vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
        end
        return nil
      end
      _323_ = (prev_in2 or get_input_and_clean_up() or _324_())
      if (nil ~= _323_) then
        local in2 = _323_
        local _327_
        if new_search_3f then
          _327_ = shortcuts[in2]
        else
        _327_ = nil
        end
        if ((type(_327_) == "table") and (nil ~= (_327_)[1]) and (nil ~= (_327_)[2])) then
          local pos = (_327_)[1]
          local ch2 = (_327_)[2]
          local shortcut = _327_
          do
            save_state_for({["dot-repeat"] = {in1 = in1, in2 = ch2, in3 = in2}, ["enter-repeat"] = {in1 = in1, in2 = ch2}})
            jump_with_wrap_21(pos)
          end
          if vim.fn.exists("#User#LightspeedLeave") then
            vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
          end
          return nil
        else
          local _ = _327_
          save_state_for({["dot-repeat"] = {in1 = in1, in2 = in2, in3 = labels[1]}, ["enter-repeat"] = {in1 = in1, in2 = in2}})
          local _330_
          local function _331_()
            if change_operation_3f() then
              handle_interrupted_change_op_21()
            end
            do
              echo_not_found((in1 .. in2))
            end
            do
            end
            if vim.fn.exists("#User#LightspeedLeave") then
              vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
            end
            return nil
          end
          _330_ = (match_map[in2] or _331_())
          if (nil ~= _330_) then
            local positions = _330_
            local _let_334_ = positions
            local first = _let_334_[1]
            local rest = {(table.unpack or unpack)(_let_334_, 2)}
            local positions_to_label
            if jump_to_first_3f then
              positions_to_label = rest
            else
              positions_to_label = positions
            end
            if (jump_to_first_3f or empty_3f(rest)) then
              jump_with_wrap_21(first)
            end
            if empty_3f(rest) then
              do
              end
              if vim.fn.exists("#User#LightspeedLeave") then
                vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
              end
              return nil
            else
              switch_off_scrolloff()
              if not (dot_repeat_3f and self["prev-dot-repeatable-search"].in3) then
                if opts.grey_out_search_area then
                  grey_out_search_area(reverse_3f)
                end
                do
                  set_beacon_groups(in2, positions_to_label, labels, shortcuts, {["repeat?"] = enter_repeat_3f})
                end
                highlight_cursor()
                vim.cmd("redraw")
              end
              local _340_
              local function _341_()
                if change_operation_3f() then
                  handle_interrupted_change_op_21()
                end
                do
                  restore_scrolloff()
                end
                do
                end
                if vim.fn.exists("#User#LightspeedLeave") then
                  vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
                end
                return nil
              end
              _340_ = (cycle_through_match_groups(in2, positions_to_label, shortcuts, enter_repeat_3f) or _341_())
              if ((type(_340_) == "table") and (nil ~= (_340_)[1]) and (nil ~= (_340_)[2])) then
                local group_offset = (_340_)[1]
                local in3 = (_340_)[2]
                restore_scrolloff()
                if (dot_repeatable_op_3f and not dot_repeat_3f) then
                  if (group_offset == 0) then
                    self["prev-dot-repeatable-search"].in3 = in3
                  else
                    self["prev-dot-repeatable-search"].in3 = nil
                  end
                end
                local _346_
                do
                  local _347_ = in3
                  if _347_ then
                    local _348_ = reverse_lookup(labels)[_347_]
                    if _348_ then
                      local _349_ = ((group_offset * #labels) + _348_)
                      if _349_ then
                        _346_ = positions_to_label[_349_]
                      else
                        _346_ = _349_
                      end
                    else
                      _346_ = _348_
                    end
                  else
                    _346_ = _347_
                  end
                end
                if (nil ~= _346_) then
                  local pos_of_active_label = _346_
                  do
                    jump_with_wrap_21(pos_of_active_label)
                  end
                  if vim.fn.exists("#User#LightspeedLeave") then
                    vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
                  end
                  return nil
                else
                  local _0 = _346_
                  if jump_to_first_3f then
                    do
                      vim.fn.feedkeys(in3, "i")
                    end
                    if vim.fn.exists("#User#LightspeedLeave") then
                      vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
                    end
                    return nil
                  else
                    if change_operation_3f() then
                      handle_interrupted_change_op_21()
                    end
                    do
                    end
                    do
                    end
                    if vim.fn.exists("#User#LightspeedLeave") then
                      vim.cmd("doautocmd <nomodeline> User LightspeedLeave")
                    end
                    return nil
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
local plug_mappings = {{"n", "<Plug>Lightspeed_s", "s:to(false)"}, {"n", "<Plug>Lightspeed_S", "s:to(true)"}, {"x", "<Plug>Lightspeed_s", "s:to(false)"}, {"x", "<Plug>Lightspeed_S", "s:to(true)"}, {"o", "<Plug>Lightspeed_s", "s:to(false)"}, {"o", "<Plug>Lightspeed_S", "s:to(true)"}, {"n", "<Plug>Lightspeed_x", "s:to(false, true)"}, {"n", "<Plug>Lightspeed_X", "s:to(true, true)"}, {"x", "<Plug>Lightspeed_x", "s:to(false, true)"}, {"x", "<Plug>Lightspeed_X", "s:to(true, true)"}, {"o", "<Plug>Lightspeed_x", "s:to(false, true)"}, {"o", "<Plug>Lightspeed_X", "s:to(true, true)"}, {"n", "<Plug>Lightspeed_f", "ft:to(false)"}, {"n", "<Plug>Lightspeed_F", "ft:to(true)"}, {"x", "<Plug>Lightspeed_f", "ft:to(false)"}, {"x", "<Plug>Lightspeed_F", "ft:to(true)"}, {"o", "<Plug>Lightspeed_f", "ft:to(false)"}, {"o", "<Plug>Lightspeed_F", "ft:to(true)"}, {"x", "<Plug>Lightspeed_t", "ft:to(false, true)"}, {"x", "<Plug>Lightspeed_T", "ft:to(true, true)"}, {"n", "<Plug>Lightspeed_t", "ft:to(false, true)"}, {"n", "<Plug>Lightspeed_T", "ft:to(true, true)"}, {"o", "<Plug>Lightspeed_t", "ft:to(false, true)"}, {"o", "<Plug>Lightspeed_T", "ft:to(true, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_s", "s:to(false, false, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_S", "s:to(true, false, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_x", "s:to(false, true, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_X", "s:to(true, true, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_f", "ft:to(false, false, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_F", "ft:to(true, false, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_t", "ft:to(false, true, true)"}, {"o", "<Plug>Lightspeed_dotrepeat_T", "ft:to(true, true, true)"}}
for _, _366_ in ipairs(plug_mappings) do
  local _each_367_ = _366_
  local mode = _each_367_[1]
  local lhs = _each_367_[2]
  local rhs_call = _each_367_[3]
  api.nvim_set_keymap(mode, lhs, ("<cmd>lua require'lightspeed'." .. rhs_call .. "<cr>"), {noremap = true, silent = true})
end
local function add_default_mappings()
  local default_mappings = {{"n", "s", "<Plug>Lightspeed_s"}, {"n", "S", "<Plug>Lightspeed_S"}, {"x", "s", "<Plug>Lightspeed_s"}, {"x", "S", "<Plug>Lightspeed_S"}, {"o", "z", "<Plug>Lightspeed_s"}, {"o", "Z", "<Plug>Lightspeed_S"}, {"o", "x", "<Plug>Lightspeed_x"}, {"o", "X", "<Plug>Lightspeed_X"}, {"n", "f", "<Plug>Lightspeed_f"}, {"n", "F", "<Plug>Lightspeed_F"}, {"x", "f", "<Plug>Lightspeed_f"}, {"x", "F", "<Plug>Lightspeed_F"}, {"o", "f", "<Plug>Lightspeed_f"}, {"o", "F", "<Plug>Lightspeed_F"}, {"n", "t", "<Plug>Lightspeed_t"}, {"n", "T", "<Plug>Lightspeed_T"}, {"x", "t", "<Plug>Lightspeed_t"}, {"x", "T", "<Plug>Lightspeed_T"}, {"o", "t", "<Plug>Lightspeed_t"}, {"o", "T", "<Plug>Lightspeed_T"}}
  for _, _368_ in ipairs(default_mappings) do
    local _each_369_ = _368_
    local mode = _each_369_[1]
    local lhs = _each_369_[2]
    local rhs = _each_369_[3]
    if ((vim.fn.mapcheck(lhs, mode) == "") and (vim.fn.hasmapto(rhs, mode) == 0)) then
      api.nvim_set_keymap(mode, lhs, rhs, {silent = true})
    end
  end
  return nil
end
add_default_mappings()
return {add_default_mappings = add_default_mappings, ft = ft, init_highlight = init_highlight, opts = opts, s = s, setup = setup}
