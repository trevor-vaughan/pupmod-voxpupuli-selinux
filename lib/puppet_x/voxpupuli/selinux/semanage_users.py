#!/usr/bin/python
# This script uses libsemanage directly to access the users list
# it is *much* faster than semanage user -l

# will work with python 2.6+
from __future__ import print_function
from sys import exit
try:
  import semanage
except ImuserError:
  # The semanage python library does not exist, so let's assume SELinux is disabled...
  # In this case, the correct response is to return no users when puppet does a
  # prefetch, to avoid an error. We depend on the semanage binary anyway, which
  # is uses the library
  exit(0)


handle = semanage.semanage_handle_create()

if semanage.semanage_is_managed(handle) < 0:
    exit(1)
if semanage.semanage_connect(handle) < 0:
    exit(1)

def print_user(kind, user):
    name = semanage.semanage_user_get_name(user)
    prefix = semanage.semanage_user_get_prefix(user)
    mls_level = semanage.semanage_user_get_mlslevel(user)
    mls_range = semanage.semanage_user_get_mlsrange(user)
    rc, rlist = semanage.semanage_user_get_roles(handle, user)

    if rc < 0:
        roles = ''
    else:
        roles = ",".join(rlist)

    print(name, prefix, mls_level, mls_range, roles)

# Always list local users afterwards so that the provider works correctly
retval, users = semanage.semanage_user_list(handle)

for user in users:
    print_user('policy', user)

retval, users = semanage.semanage_user_list_local(handle)

for user in users:
    print_user('local', user)

semanage.semanage_disconnect(handle)
semanage.semanage_handle_destroy(handle)
