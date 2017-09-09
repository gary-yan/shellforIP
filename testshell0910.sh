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

while getopts :n:c2rftw opt ;do
	#前面的冒号：表示不输入N的值不报错
	case $opt in
	n) N=$OPTARG 
		;;
	c)
	#echo" Which IP address makes the most number of connection attempts?"
	#awk'{print $1}'thttpd.log
	 #cat thttpd.log 
	# cat thttpd.log|awk '{print $1}'|sort|uniq|wc – l
	 # awk '{print $1}' thttpd.log
	 # cat thttpd.log|awk '{print $1}'|sort|uniq

	  # cat thttpd.log|awk '{print $1}' | sort | uniq -c | sort -k1nr | head -n $N
	 #sort -k1nr  k--表示对第k列进行排序 n－－表示按数值排列  r--表示逆向排列  
	 #uniq -c uniq 命令删除文件中的重复行。 -c 在输出行前面加上每行在输入文件中出现的次数。
	 SZC=$(cat thttpd.log|awk '{print $1}' | sort | uniq -c | sort -k1nr | head -n $N)
	 echo ${SZC[@]}
	 echo "-c: $SZC[2] $SZC[1] where ${SZC[1]} is the number of connection attempts"需要正确的数组表示方法
	 #17:18  需要正确的数组表示方法

	;;
	2)
	#echo"Which address makes the most number of successful attempts?"
	cat thttpd.log | awk '($9 ~ /2.*.*/)' | awk '{print $1}' | sort | uniq -c | sort -k1nr | head -$N
	#统计所有状态码为200的请求
	;;
	r)
# 	echo"What are the most common results codes and where do they come from?"
	# cat thttpd.log | awk '{print $9}' | sort |uniq -c | sort -k1nr 
	status_data=$(cat thttpd.log | awk '{print $9}'| sort | uniq -c | sort -k1nr | head -1)
	 echo $status_data
	#统计出现最多的状态码
	 cat thttpd.log | awk '($9 = '404')'| sort | awk '{print $1}' | sort | uniq -c | sort -k1nr | head -$N
	;;
	f)

	cat thttpd.log | awk '($9 ~ /4.*.*/)'| sort | awk '{print $1}' | sort | uniq -c | sort -nr | head -$N


	;;
	t)	
	cat thttpd.log | awk '{print $1,$10}' | sed /"-"/d | sort | awk '{sum[$1]+=$2;}END{for(i in sum){{print i" "sum[i];}}}' | sort -k2rn | head -$N

	# echo"Which IP number get the most bytes sent to them?"
	#sss=$(cat thttpd.log | awk '{print $10}' thttpd.log | awk '{print $1}' | sort -nr | head -1)
	#echo $sss
	# cat thttpd.log | awk -F, '($10 = '$sss')' | awk '{print $1}' | sort | uniq -c | sort -k1nr 
	#how to read the variable $sss

	#cat thttpd.log | awk '($10 | sort -nr | head -5)' | awk '{print $1}'
		#thttpd.log| awk '{print $1}' | sort | uniq -c | sort -k1nr| head -10
	;;
	w)
	cat thttpd.log | awk '{print $1,$10}' | sed /"-"/d | sort | awk '{sum[$1]+=$2;}END{for(i in sum){{print i" "sum[i];}}}' | sort -k2rn
	#| awk '($10 ~ /[2-3].*.*/)' |
	 # cat thttpd.log | awk '{print $9}' | sort |uniq -c | sort -k1nr 
	 # cat thttpd.log | awk '($10 ~ /17401502/)' | awk '{print $1}' | sort | uniq -c | sort -k1nr 



	 ;;

	
	esac
done