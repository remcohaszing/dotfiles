# -*- encoding: utf-8 -*-

from __future__ import absolute_import
from __future__ import unicode_literals

import atexit
import collections  # noqa
import datetime  # noqa
import io  # noqa
import json  # noqa
import os
#import pprint.pprint as pp
import re  # noqa
import readline
import rlcompleter  # noqa
import shutil  # noqa
import sys  # noqa

try:
    from unittest import mock
except ImportError:
    try:
        import mock  # noqa
    except:
        pass

try:
    import pathlib
except ImportError:
    pass


readline.parse_and_bind('tab: complete')
histfile = os.path.expanduser('~/.cache/python/history.py')
histdir = os.path.dirname(histfile)
if not os.path.exists(histdir):
    os.mkdir(histdir)
if os.path.exists(histfile):
    readline.read_history_file(histfile)
atexit.register(readline.write_history_file, histfile)
del histfile
del histdir
