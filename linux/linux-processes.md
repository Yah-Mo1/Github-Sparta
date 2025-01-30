learning about:

what processes are in linux

how to identify processes? what is the command
ps PID
ps -aux

How to kill a process?
kill command

kill gracefully --> use kill -15 pid --> where pid is process id
--> how does it wor? first it kills any child processes attached to the parent process, then kills the parent process

brute force kill --> kill -9 pid command
--> kills parent process --> but if parent proces has any child processes running, these child processes wont be killed and they will continmue running and using cpu and memory
these are known as zombie processes
