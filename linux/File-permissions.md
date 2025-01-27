File permissions:
Controls who can read, write, and execute a file.
rwx -> read, write, execute.
User -> Group -> Other

chmod -> changes the permissions of a file.
chmod 777 -> gives everyone read, write, and execute permissions.
chmod 755 -> gives the owner read, write, and execute permissions, and the group and others read and execute permissions.

chmod u+x -> gives the owner execute permissions.
chmod g+w -> gives the group write permissions.
chmod o-r -> removes the other read permissions.
