#------------------------------------------------------------------------------
# Enable auto import modules using pyflyby
#------------------------------------------------------------------------------
## see [here](https://waylonwalker.com/pyflyby/).
from IPython import get_ipython
import subprocess
from matplotlib.pyplot import rcParams

# set default plot theme
import seaborn as sns

sns.set_style(style="darkgrid", rc={'font.family': ['Source Serif Pro', 'Source Han Serif CN']})
sns.set_context("notebook", font_scale=1.25, rc = {
        "lines.linewidth": 1.5,
        "lines.markersize": 5,})
rcParams['mathtext.fontset'] = 'cm'

##ipython = get_ipython()

##try:
##    ipython.run_line_magic("load_ext", "pyflyby")
##except ModuleNotFoundError:
##    print("installing pyflyby")
##    subprocess.Popen(
##            ["pip", "install", "--user", "pyflyby"],
##            stdout=subprocess.DEVNULL,
##            stderr=subprocess.DEVNULL,
##            ).wait()
##    ipython.magic("load_ext pyflyby")
##

