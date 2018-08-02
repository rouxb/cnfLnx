-- Luakit configuration
-- Local settings could also be set with :settings cmd
local settings = require "settings"
local modes = require "modes"

-- Homepage
settings.window.home_page = "https://luakit.github.io"

-- Seach engines
local engines = settings.window.search_engines
engines.qwant = "https://qwant.com/?q=%s"
engines.github = "https://github.com/search?q=%s"
engines.wikipedia = function(arg)
  local l, s = arg:match("^(%a%a):%s*(.+)")
  if l then
    return "https://" .. l .. ".wikipedia.org/wiki/Special:Search?search=" .. s
  else
    return "https://en.wikipedia.org/wiki/Special:Search?search=" .. arg
  end
end
-- default engine
engines.default = engines.qwant


-- Download location
local downloads = require "downloads"
downloads.default_dir = os.getenv("HOME")  .. "/Downloads"

-- Follow link with letter {{{
local select = require "select"

select.label_maker = function ()
    local chars = charset("aoeuidhtnspyfgcrl")
    return trim(sort(reverse(chars)))
end
-- }}}

-- View pdf in external editor
local viewpdf = require "viewpdf"

-- Play video in external player {{{
modes.add_binds("normal", {
    { "v", "Play video in page", function (w)
        -- Same function as above
        local view = w.view
        local uri = view.hovered_uri or view.uri
        if uri then

            luakit.spawn(string.format("urxvt -e cclive --stream best --filename-format '%%t.%%s' "
                .. "--output-dir %q --exec='mplayer \"%%f\"' %q", os.getenv("HOME") .."/Downloads", uri))
            -- Alternatively, use mpv.
            -- luakit.spawn(string.format("mpv --geometry=1366x768 %s", uri))
        end
    end },
}) -- }}}
