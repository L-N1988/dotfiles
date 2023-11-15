import gdb

class ppbin(gdb.Command):
    def __init__(self):
        super(ppbin, self).__init__("ppbin", gdb.COMMAND_USER)

    def invoke(self, arg, tty):
        print arg

        arg_list = gdb.string_to_argv(arg)

        if len(arg_list) < 2:
            print "usage: <address>, <byte-count>"
            return
        res = gdb.execute("x/%sxt %s" %(arg_list[1], arg_list[0]), False, True)
        res = res.split("\t")
        ii = 0
        for bv in res:
            if ii % 4:
                print "%s-%s-%s-%s-%s-%s-%s-%s" %(bv[0:4],   bv[4:8],
                                                  bv[8:12],  bv[12:16], \
                                                          bv[16:20], bv[20:24], \
                                                          bv[24:28],bv[28:32])
            ii += 1

ppbin()
