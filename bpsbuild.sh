#!/bin/bash
echo "synchronizing..."

bps=("bp2" "bp3" "bp4")
bpips=("192.168.105.205" "192.168.105.206" "192.168.105.207")

# ${#users[@]} ��������Ĵ�С
#for ((i=0; i<${#bps[@]};i++));
#do
#	echo -e "\033[31m----------------------------------------------------------------------\033[0m"
#	echo "do  ${bps[i]}"
#	echo -e "\033[31m----------------------------------------------------------------------\033[0m"
#        \cp -f /data/zjw/work/gst_install/*.sh /data/bps/${bps[i]}/work/gst_install/
#	echo -e "\033[35m ${bps[i]}: ���ڸ��´���...\033[0m"
#	docker exec -it centos_${bps[i]} /bin/bash -c "/work/gst_install/test.sh"
#done

# ${#users[@]} ��������Ĵ�С
for ((i=0; i<${#bps[@]};i++));
do
	echo -e "\033[31m----------------------------------------------------------------------\033[0m"
	echo "do  ${bps[i]}"
	echo -e "\033[31m----------------------------------------------------------------------\033[0m"
        \cp -f /data/zjw/work/gst_install/*.sh /data/bps/${bps[i]}/work/gst_install/
	echo -e "\033[35m ${bps[i]}: ����ֹͣ����������...\033[0m"
	docker exec -it centos_${bps[i]} /bin/bash -c "/work/gst_install/stop.sh"
done

for ((i=0; i<${#bps[@]};i++));
do
	echo -e "\033[31m----------------------------------------------------------------------\033[0m"
	echo "do  ${bps[i]}"
	echo -e "\033[31m----------------------------------------------------------------------\033[0m"
	echo -e "\033[35m ${bps[i]}: ���ڱ���...\033[0m"
	\cp -f /data/zjw/profile/opt/cmake-3.10.2/bin/* /data/bps/${bps[i]}/profile/opt/cmake-3.10.2/bin/
	docker exec -it centos_${bps[i]} /bin/bash -c "cd /work/gst_install && /work/gst_install/gst/build.sh"
done


echo "done..."