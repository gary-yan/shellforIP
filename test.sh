#!/bin/bash
echo " "
echo "usage ./log_sum.sh [-n N] (-c|-2|-r|-f-t) <file>"
echo "[-n N] limit the results to N"
echo "-c show the IP with the most number of connection attempts"
echo "-2 show the IP with the most number of successful attempts"
echo "-r show the most common result codes"
echo "-f show the IP which get the most butes sent to them"  
echo ""
# echo "hello"

while getopts n:c2rftw opt ;do
	case $opt in
	n)
 	N=$OPTARG
	;;
	c)
	#echo" Which IP address makes the most number of connection attempts?"
	#awk'{print $1}'thttpd.log
	 #cat thttpd.log 
	# cat thttpd.log|awk '{print $1}'|sort|uniq|wc – l
	 # awk '{print $1}' thttpd.log
	 # cat thttpd.log|awk '{print $1}'|sort|uniq
	  cat thttpd.log|awk '{print $1}' | sort | uniq -c | sort -k1nr | head -10
	 #sort -k1nr  k--表示对第k列进行排序 n－－表示按数值排列  r--表示逆向排列  
	 #uniq -c uniq 命令删除文件中的重复行。 -c 在输出行前面加上每行在输入文件中出现的次数。

	;;
	2)
	#echo"Which address makes the most number of successful attempts?"
	cat thttpd.log | awk '($9 ~ /200/)' | awk '{print $1}' | sort | uniq -c | sort -k1nr | head -10
	#统计所有状态码为200的请求
	;;
	r)
# 	echo"What are the most common results codes and where do they come from?"
	# cat thttpd.log | awk '{print $9}' | sort |uniq -c | sort -k1nr 
	cat thttpd.log | awk '{print $9}'| sort | uniq -c | sort -k1nr | head -1 
	#统计出现最多的状态码
	cat thttpd.log | awk '($9 ~ /404/)'| sort | awk '{print $1}' | sort | uniq -c | sort -k1nr | head -10
	;;
	f)
	echo"What are the most common result codes that indicate failure (no
auth, not found etc) and where do they come from?"
	;;
	t)
	# echo"Which IP number get the most bytes sent to them?"
	cat thttpd.log | awk '{print $10}' thttpd.log | awk '{print $1}' | sort -nr | head -5  
	#cat thttpd.log | awk '($10 | sort -nr | head -5)' | awk '{print $1}'
		#thttpd.log| awk '{print $1}' | sort | uniq -c | sort -k1nr| head -10
	;;
	w)
	 cat thttpd.log | awk '{print $9}' | sort |uniq -c | sort -k1nr 
	 cat thttpd.log | awk '($10 ~ /17401502/)' | awk '{print $1}' | sort | uniq -c | sort -k1nr 



	 ;;

	
	esac
done