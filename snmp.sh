echo "Qual o IP do HOST?" 

read host 

  

#echo "Qual a comunidade?" 

#read comunidade 

  

#for host in $(cat hosts.txt) 

#do 

  

echo "" 

  

  

dsysObjectID=`snmpget -v 2c -c public3 $host .1.3.6.1.2.1.1.2.0 | awk '{print $4}' | cut -f2-5 -d"."` 

psysObjectID=`snmpget -v 2c -c public $host .1.3.6.1.2.1.1.2.0 | awk '{print $4}' | cut -f2-5 -d"."` 

asysObjectID=`snmpget -v 2c -c public2 $host .1.3.6.1.2.1.1.2.0 | awk '{print $4}' | cut -f2-5 -d"."` 

nsysObjectID=`snmpget -v 2c -c public4 $host .1.3.6.1.2.1.1.2.0 | awk '{print $4}' | cut -f2-5 -d"."` 

  

if [ "$psysObjectID" != "" ] 

then 

comunidade=public 

  

elif [ "$dsysObjectID" != "" ] 

then 

comunidade=public2 

  

elif [ "$asysObjectID" != "" ] 

then 

comunidade=public3

  

elif [ "$nsysObjectID" != "" ] 

then 

comunidade=public3

  

fi 

  

  

  

  

sysObjectID=`snmpget -v 2c -c $comunidade $host .1.3.6.1.2.1.1.2.0 | awk '{print $4}' | cut -f2-5 -d"."` 

sysDescr=`snmpget -v 2c -c $comunidade $host .1.3.6.1.2.1.1.1.0 | awk '{print $4,$5}' | cut -f2-5 -d"."` 

sysName=`snmpget -v 2c -c $comunidade $host .1.3.6.1.2.1.1.5.0 | awk '{print $4,$5,$6,$7,$8,$9}' | cut -f2-5 -d"."` 

sysUpTime=`snmpget -v 2c -c $comunidade $host .1.3.6.1.2.1.1.3.0 | awk '{print $5,$6,$7}' | cut -f1 -d"."` 

ifDescr=`snmpbulkwalk -v 2c -c $comunidade $host .1.3.6.1.2.1.2.2.1.2 | awk '{print $1,$2,$4}'| cut -f2-5 -d":"` 

ipAdEntIfIndex=`snmpbulkwalk -v 2c -c $comunidade $host .1.3.6.1.2.1.4.20.1.2 | awk '{print $1,$2,$4}'| cut -f2-5 -d":"` 

ifOperStatus=`snmpbulkwalk -v 2c -c dcba1002 10.202.10.1 .1.3.6.1.2.1.2.2.1.8 | awk '{print $1,$2,$4,$5}'| cut -f2-5 -d":"` 

  

  

#DescIndex3=`snmpget -v 2c -c $comunidade $host .1.3.6.1.2.1.2.2.1.2.3 | awk '{print $4}'` 

#DescIndex5=`snmpget -v 2c -c $comunidade $host .1.3.6.1.2.1.2.2.1.2.5 | awk '{print $4}'` 

  

#if [[ $DescIndex3 != ether1-wan-pri || $DescIndex5 != ether3-wan-sec ]] 

#then 

  

  

echo "- COMUNIDADE: SNMP v2 $comunidade" 

echo "- IP: $host" 

echo "- sysObjectID: $sysObjectID" 

echo "- sysDescr: $sysDescr" 

echo "- sysName: $sysName" 

echo "- sysUpTime: $sysUpTime" 

#echo "- ifDescr:" 

#echo "$ifDescr" 

#echo "- ipAdEntIfIndex:" 

#echo "$ipAdEntIfIndex" 

#echo "- ifOperStatus:" 

#echo "$ifOperStatus" 

echo "" 

  

  

#fi 

  

#done 
