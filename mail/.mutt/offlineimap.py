#!/usr/bin/python
from subprocess import check_output


def get_pass(account):
    return check_output("pass mail/" + account, shell=True).rstrip()
