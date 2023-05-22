## 三星 SSD 850EVO 256G

|   路径   |    容量  |常剩空间|
|----------|---------|--------|
|/         |35G      |20G    |
|/boot     |1G       |       |
|/var      |26G      |10G    |
|/home     |50G      |20G    |
|swap      |8G       |       |
|不占用     |8G       |       |
|/BeYourself|otherAll|

```
Filesystem      Size  Used Avail Use% Mounted on
udev            3.9G     0  3.9G   0% /dev
tmpfs           789M   18M  771M   3% /run
/dev/sdb1        33G  8.8G   23G  29% /
tmpfs           3.9G  211M  3.7G   6% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sdb7        47G   17G   28G  38% /home
/dev/sdb5       945M  106M  775M  13% /boot
/dev/sdb6        25G  1.3G   22G   6% /var
/dev/sdb9       108G   15G   88G  15% /beyourself
tmpfs           789M  120K  788M   1% /run/user/1000
/dev/sda7       105G   85G   20G  82% /media/tom/document
/dev/sda5       105G   86G   19G  82% /media/tom/software
```


## 没有启动盘，只有Windows如何进入Ubuntu
1. http://blog.csdn.net/ouening/article/details/51868264
2. http://www.linuxidc.com/Linux/2014-04/100369.htm
3. http://jingyan.baidu.com/article/e4d08ffdace06e0fd2f60d39.html

## 再次确认分区大小

|	Filesystem    	|	Size  	|	Used	|	Avail	|Use%	|	Mounted on	            |
|	----------	    |----------	|	--------|	-------	|-----	|	----------	            |
|	udev          	|	3.9G  	|	0	    |	 3.9G	|	0%	|	/dev    	            |
|	tmpfs         	|	789M  	|	 18M	|	 771M	|	3%	|	/run    	            |
|	/dev/sda9     	|	 29G  	|	 26G	|	 1.1G	|	96%	|	/	                    |
|	tmpfs         	|	3.9G  	|	8.8M	|	 3.9G	|	1%	|	/dev/shm	            |
|	tmpfs         	|	5.0M  	|	4.0K	|	 5.0M	|	1%	|	/run/lock	            |
|	tmpfs         	|	3.9G  	|	0	    |	 3.9G	|	0%	|	/sys/fs/cgroup	        |
|	/dev/sda10    	|	180M  	|	106M	|	  62M	|	64%	|	/boot	                |
|	/dev/sda11    	|	 58G  	|	 46G	|	 9.0G	|	84%	|	/home	                |
|	cgmfs         	|	100K  	|	0	    |	 100K	|	0%	|	/run/cgmanager/fs	    |
|	tmpfs         	|	789M  	|	 76K	|	 789M	|	1%	|	/run/user/1000  	    |
|	/dev/sda7     	|	 95G  	|	 64G	|	  31G	|	68%	|	/media/tom/other	    |
|	/dev/sda6     	|	 97G  	|	 36G	|	  61G	|	37%	|	/media/tom/VideosBooks	|

|Filesystem |Size  |Used|Avail	|Use%	|Mounted on|提出容量  |提出目录|剩余空间 |
|---------- |------|----|-------|-----	|----------|-------- |--------|--------|
|/dev/sda9  | 29G  | 26G| 1.1G	|	96%	|/	       |15G      |/var    |16G     |
|/dev/sda10 |180M  |106M|  62M	|	64%	|/boot	   |         |        |        |
|/dev/sda11 | 58G  | 46G| 9.0G	|	84%	|/home	   |21G      |个人目录 |30G     |
|swap       |   8G |    |     	|	  	|    	   |         |        |        |