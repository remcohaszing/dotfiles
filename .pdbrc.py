import pdb

# Only use dependencies of pdbpp here.
from pygments.console import colorize


class Config(pdb.DefaultConfig):
    #prompt = colorize('green', '(Pdb) ')
    sticky_by_default = True
    current_line_color = 0
