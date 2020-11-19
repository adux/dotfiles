#!/usr/bin/env python3
import os
import i3ipc


def on_shutdown(conn):
    os.system('sudo /usr/bin/prime-switch')


conn = i3ipc.Connection()

conn.on('ipc_shutdown', on_shutdown)

conn.main()
