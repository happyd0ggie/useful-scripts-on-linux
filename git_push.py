#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pexpect
import os
import sys

def usage():
    """
    1. export github_password='your_github_password'
    2. ./git_push.py
    """
    print('''
Usage:
    ./git_push.py
Note:
    you should set your github password in current shell
    e.g. export github_password='your_github_password'
    ''')

def do_push():
    """Push local modifications to remote repository.

    Args:
        None.
    Returns:
        None.
    Raises:
        None.
    """
    password = os.getenv('github_password')
    if not password:
        print('your github password is not set yet')
        usage()
        sys.exit(1)
    cmd = 'git push'
    git = pexpect.spawn(cmd)
    while True:
        index = git.expect(['Username', pexpect.TIMEOUT])
        if index == 0:
            break
        elif index == 1:
            pass
        else:
            pass
    git.sendline('shengdexiang')
    git.expect('Password.*')
    git.sendline(password)
    git.interact()

def main():
    do_push()

if __name__ == '__main__':
    main()
