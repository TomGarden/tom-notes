
import subprocess,re
 
//这个 python 脚本时候从来都没用过的

def toHexPort(port):
    hexport = str(hex(int(port)))
    return hexport.strip('0x').upper()
 
def finduid(protocol, entry):
    if (protocol=='tcp' or protocol=='tcp6'):
        uid = entry.split()[-10]
    else: # udp or udp6
        uid = entry.split()[-6]
    uid = int(uid)
    if (uid > 10000): # just for non-system app
        return 'u0_a'+str(uid-10000)
    else:
        return -1
 
def main():
    netstat_cmd = "adb shell netstat | grep -Ei 'listen|udp*'"
    #netstat_cmd = "adb shell netstat "
    grep_cmd = "adb shell grep"
    proc_net = "/proc/net/"
 
# step 1, find interesting port
    orig_output = subprocess.check_output(netstat_cmd, shell=True)
    list_line = orig_output.split('\r\n')
 
    apps = []
    strip_listline = []
    pattern = re.compile("^Proto") # omit the first line
 
    for line in list_line:
        if (line != '') and (pattern.match(line)==None):
 
# step 2, find uid in /proc/net/[protocol] based on port
            socket_entry = line.split()
            protocol = socket_entry[0] 
            port = socket_entry[3].split(':')[-1]
            grep_appid = grep_cmd+' '+ toHexPort(port)+' '+proc_net + protocol
            net_entry = subprocess.check_output(grep_appid, shell=True)
            uid = finduid(protocol, net_entry)
# step 3, find app username based on uid
            if (uid == -1): continue
            applist = subprocess.check_output('adb shell ps | grep '+uid, shell=True).split()
            app = applist[8]
            apps.append(app)
            strip_listline.append(line)
 
    itapp= iter(apps)
    itline=iter(strip_listline)
# last, add app in orig_output of sockets
    print ("Package                  Proto Recv-Q Send-Q         Local Address          Foreign Address        State\r\n")
    try:
        while True:
            print itapp.next()+' '+itline.next()
    except StopIteration:
        pass
 
if __name__ == '__main__':
    main()
