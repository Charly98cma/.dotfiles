from __future__ import (absolute_import, division, print_function)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (default, bold, reverse, dim, BRIGHT, default_colors)

WHITE = 15 #FFFFFF
BLACK = 0 #000000
ORANGE = 214 #FFAF00 (should be FBA922)
GREY = 240 #585858 (should be 5B5B5B)
GREEN = 148 #AFD700 (should be 8FCE00)
RED = 203 #FF5F5F (should be FF5555)

class Solarized(ColorScheme):
    progress_bar_color = WHITE

    def use(self, context):  # pylint: disable=too-many-branches,too-many-statements
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.empty or context.error:
                fg = RED

            if context.border:
                fg = default

            if context.media or context.container:
                fg = ORANGE
                attr |= (BRIGHT & bold) if context.selected else dim

            if context.file or context.directory or context.device:
                fg=WHITE
                attr |= (BRIGHT & bold) if context.selected else dim
            elif context.executable and not any((context.media, context.container, context.fifo, context.socket)):
                fg = GREEN
                attr |= (BRIGHT & bold) if context.selected else dim

            if context.socket or context.fifo:
                fg = ORANGE
                attr |= (BRIGHT & bold) if context.selected else dim

            if context.link:
                fg = RED if context.bad else ORANGE
                attr |= (BRIGHT & bold) if context.selected else dim

            if not context.selected and (context.cut or context.copied):
                bg = GREY
                attr |= bold

            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold

            if context.badinfo:
                if attr & reverse:
                    bg = RED
                else:
                    fg = RED

            if context.inactive_pane:
                fg = RED

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = GREEN
                if context.bad:
                    bg = RED
            elif context.directory:
                fg = WHITE
            elif context.tab:
                fg = WHITE
            elif context.link:
                fg = ORANGE
                attr |= BRIGHT if context.selected else dim

        elif context.in_statusbar:

            if context.permissions:
                if context.bad:
                    fg = RED

            if context.marked:
                attr |= bold

            if context.message:
                if context.bad:
                    bg = RED

            if context.loaded:
                bg = GREY

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = RED

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        return fg, bg, attr
