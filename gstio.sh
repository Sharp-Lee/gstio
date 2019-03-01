#!/bin/bash

ret=$(ps -ef |grep mongod|grep -v grep|wc -l)
if [ $ret -lt 2 ];then
   echo "the mongod service is ERR"
   systemctl start mongod
fi
mongo 127.0.0.1:27017/gstdb  --eval 'db.dropDatabase();'


chown -R mongod:mongod /work/gst_install/mongo
chmod -R 777 /work/gst_install/mongo

alias clgst='clgst -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8900'

cd  /work/gst_install/test1/

rm -rf  blocks/
rm -rf snapshots/
rm -rf state/
rm -rf  bpnode.log

sleep 2s

nohup nodgst --data-dir ./ --config-dir ./  --genesis-json=genesis.json --max-transaction-time=3000 > /work/gst_install/test1/bpnode.log 2>&1 &

cd  /work/gst_install/test2/

rm -rf  blocks/
rm -rf snapshots/
rm -rf state/
rm -rf  bpnode.log

sleep 2s

nohup nodgst --data-dir ./ --config-dir ./  --genesis-json=genesis.json --max-transaction-time=3000 > /work/gst_install/test2/bpnode.log 2>&1 &


cd  /work/gst_install/test3/

rm -rf  blocks/
rm -rf snapshots/
rm -rf state/
rm -rf  bpnode.log

sleep 2s

nohup nodgst --data-dir ./ --config-dir ./  --genesis-json=genesis.json --max-transaction-time=3000 > /work/gst_install/test3/bpnode.log 2>&1 &


cd  /work/gst_install/test4/

rm -rf  blocks/
rm -rf snapshots/
rm -rf state/
rm -rf  bpnode.log

sleep 2s

nohup nodgst --data-dir ./ --config-dir ./  --genesis-json=genesis.json --max-transaction-time=3000 > /work/gst_install/test4/bpnode.log 2>&1 &



echo "PW5Ka7m2J2wLAhA3wbJPQ9XhFMc5KVLVE2qYTETr6cEvwqyrTGJAw" | clgst wallet unlock

clgst wallet list

#clgst wallet import --private-key 5JfxbuzqBVTc1SsHQ9RFY4aExuNtGZapGyCe6uapdZAPwKcBAAz
#clgst wallet import --private-key 5KarHtfxsJY9Ei8kmZpFo5GeA3rEWmC6Qe9UubkKfvLchE5MbtE
#clgst wallet import --private-key 5JF6qVx2otj5d6TqzGxpQQgoULj9r2GCZH5NPw16PwPS3BGFFEv
#clgst wallet import --private-key 5K4SqTVrWVauwM6je8pWxi9aAwoqtwnByqZcmZnVSaAc666793X

sleep 3s


STALE_NOD=$(netstat -ln|grep -o 8888)


echo -e "\033[32m ���ڴ���ϵͳ�ʻ�...\033[0m"

clgst create account gstio gstio.bpay GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.msig GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.names GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.ram GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.ramfee GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.fee GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.saving GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.stake GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.token GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.vpay GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst create account gstio gstio.vote GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU

echo -e "\033[32m ���ڰ�װ��Լ...\033[0m"
cd /work/gst_install/gst

echo -e "\033[32m 1. ��װgstio.bios��Լ...\033[0m"
#clgst set contract gstio build/contracts/gstio.bios -p gstio
 

echo -e "\033[32m 2. ��װgstio.token��Լ...\033[0m"
clgst set contract gstio.token build/contracts/gstio.token -p gstio.token

echo -e "\033[32m 3. ��װgstio.msig��Լ...\033[0m"
clgst set contract gstio.msig build/contracts/gstio.msig -p gstio.msig

echo -e "\033[32m 4. ���д��� GST ������gstio ...\033[0m"
clgst push action gstio.token create '["gstio", "1000000000.0000 GST"]' -p gstio.token

echo -e "\033[32m 5. ������GST�ʲ�����gstio�˻� ...\033[0m"
clgst push action gstio.token issue '["gstio", "700000000.0000 GST", "issue message"]' -p gstio

echo -e "\033[32m 6. ��װgstio.system ��Լ...\033[0m"
clgst set contract gstio build/contracts/gstio.system -p gstio -x 1000
 

echo "gstio account gstio info:"
clgst get account gstio

sleep 2s

echo -e "\033[31m----------------------------------------------------------------------\033[0m"
echo -e "\033[32m create account voter1 \033[0m"
echo -e "\033[31m----------------------------------------------------------------------\033[0m"
clgst system newaccount gstio voter1 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU

echo -e "\033[31m----------------------------------------------------------------------\033[0m"
echo -e "\033[32m create account voter2/voter3/voter4/voter5 \033[0m"
echo -e "\033[31m----------------------------------------------------------------------\033[0m"

clgst system newaccount gstio voter2 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst system newaccount gstio voter3 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst system newaccount gstio voter4 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU
clgst system newaccount gstio voter5 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU

echo -e "\033[35m create account bp1\033[0m"
clgst system newaccount gstio bp1 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU

echo -e "\033[35m create account bp2\033[0m"
clgst system newaccount gstio bp2 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU

echo -e "\033[35m create account bp3\033[0m"
clgst system newaccount gstio bp3 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU

echo -e "\033[35m create account bp4\033[0m"
clgst system newaccount gstio bp4 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz GST659CGCoztnkD5cswR6eeLHZS4Le1E5QJzX6zt7e45j8MEwVaGU

echo -e "\033[31m----------------------------------------------------------------------\033[0m"
echo -e "\033[35m ��bp1ע��Ϊ�����ڵ�...\033[0m"
clgst system regproducer bp1 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz

echo -e "\033[35m ��bp2ע��Ϊ�����ڵ�...\033[0m"
clgst system regproducer bp2 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz

echo -e "\033[35m ��bp3ע��Ϊ�����ڵ�...\033[0m"
clgst system regproducer bp3 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz

echo -e "\033[35m ��bp4ע��Ϊ�����ڵ�...\033[0m"
clgst system regproducer bp4 GST8MfTEtHsMU1AGL4LYbYx3eiU9iVK3K6WXUEoJHkieVAbj9gHDz
echo -e "\033[31m----------------------------------------------------------------------\033[0m"

echo "account gstio currency balance:"
clgst get currency balance gstio.token gstio GST

echo "GST currency stats:"
clgst get currency stats gstio.token GST

echo -e "\033[31m----------------------------------------------------------------------\033[0m"
echo -e "\033[32m gstioת�˵�ͶƱ�û� \033[0m"
echo -e "\033[31m----------------------------------------------------------------------\033[0m"


clgst transfer gstio  gstio.vote "50000000.0000 GST" -p gstio

echo -e "\033[32m ��151000000.0000 GST ��gstioת�˵�voter1...\033[0m"
clgst transfer gstio voter1 "151000000.0000 GST" -p gstio

echo -e "\033[32m ��120000.0000 GST ��gstioת�˵�voter2...\033[0m"
clgst transfer gstio voter2 "151000000.0000 GST" -p gstio

echo -e "\033[32m ��120000.0000 GST ��gstioת�˵�voter3...\033[0m"
clgst transfer gstio voter3 "151000000.0000 GST" -p gstio

echo -e "\033[32m ��120000.0000 GST ��gstioת�˵�voter4...\033[0m"
clgst transfer gstio voter4 "120000.0000 GST" -p gstio

echo -e "\033[32m ��120000.0000 GST ��gstioת�˵�voter5...\033[0m"
clgst transfer gstio voter5 "120000.0000 GST" -p gstio

echo -e "\033[31m----------------------------------------------------------------------\033[0m"


echo -e "\033[32m ��12000.0000 GST ��gstioת�˵�bp1...\033[0m"
clgst transfer gstio bp1 "12000.0000 GST" -p gstio

echo -e "\033[32m ��12000.0000 GST ��gstioת�˵�bp2...\033[0m"
clgst transfer gstio bp2 "12000.0000 GST" -p gstio

echo -e "\033[32m ��12000.0000 GST ��gstioת�˵�bp3...\033[0m"
clgst transfer gstio bp3 "12000.0000 GST" -p gstio

echo -e "\033[32m ��12000.0000 GST ��gstioת�˵�bp4...\033[0m"
clgst transfer gstio bp4 "12000.0000 GST" -p gstio

echo -e "\033[31m----------------------------------------------------------------------\033[0m"




echo -e "\033[32m voter1 ��Ѻ 150000000.0000 GST for cpu, 0 GST for net...\033[0m"
clgst system delegatebw voter1 voter1 "50000000.0000 GST" 

echo -e "\033[32m voter2 ��Ѻ 150000000.0000 GST for cpu, 10000.0000 GST for net...\033[0m"
clgst system delegatebw voter2 voter2 "50000000.0000 GST" 

echo -e "\033[32m voter3 ��Ѻ 90000.0000 GST for cpu, 10000.0000 GST for net...\033[0m"
clgst system delegatebw voter3 voter3 "50000000.0000 GST" 

echo -e "\033[32m voter4 ��Ѻ 90000.0000 GST for cpu, 10000.0000 GST for net...\033[0m"
clgst system delegatebw voter4 voter4 "90000.0000 GST" 

echo -e "\033[32m voter5 ��Ѻ 1.0000 GST for cpu, 0.0000 GST for net...\033[0m"
clgst system delegatebw voter5 voter5 "1.0000 GST" 

echo -e "\033[31m----------------------------------------------------------------------\033[0m"

#echo -e "\033[32m voter1 ͶƱѡ�ٽڵ� bp1...\033[0m"
#clgst system voteproducer prods voter1  bp1
#clgst system voteproducer prods voter2  bp2
#clgst system listproducers  

echo "account voter1 info:"
clgst get account voter1

echo "account voter2 info:"
clgst get account voter2

echo "account bp1 info:"
clgst get account bp1

echo -e "\033[35m �ȴ�������Ϣ���� 2s...\033[0m"
sleep 2s

echo "��ǰ������Ϣ..."
clgst get info

sleep 2s


cd /work/gst_install

sleep 1s

echo "PW5Ka7m2J2wLAhA3wbJPQ9XhFMc5KVLVE2qYTETr6cEvwqyrTGJAw" | clgst wallet unlock

sleep 1s
clgst wallet list

echo -e "\033[35m ���������������̨����...\033[0m"
systemctl start nginx
sleep 1s

echo -e "\033[35m �������������ǰ�˷���...\033[0m"
cd /work/gst_install/tracker/frontend
nohup ng serve --host 0.0.0.0 --port 4200 >/dev/null 2>&1 &
sleep 1s

systemctl status nginx
ps -al

netstat -lntp

echo "done..."
