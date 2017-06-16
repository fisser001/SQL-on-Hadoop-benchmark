#!/bin/bash
rm <$PATH>
for i in 1 2 3 4
do 

        echo "-------------------------------------------QUERY-1----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-1----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select l_returnflag, l_linestatus, sum(l_quantity) as sum_qty, sum(l_extendedprice) as sum_base_price, sum(l_extendedprice*(1-l_discount)) as sum_disc_price, sum(l_extendedprice*(1-l_discount)*(1+l_tax)) as sum_charge, avg(l_quantity) as avg_qty, avg(l_extendedprice) as avg_price, avg(l_discount) as avg_disc, count(*) as count_order from hive.paper.lineitem_1 where l_shipdate <= date '1998-12-01' - interval '90' day (3) group by l_returnflag, l_linestatus order by l_returnflag, l_linestatus; " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM'

for i in 1 2 3 4
do 

        echo "-------------------------------------------QUERY-3----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-3----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select o_orderkey, sum(l_extendedprice*(1-l_discount)) as revenue, o_orderdate, o_shippriority from hive.paper.lineitem_1 where c_mktsegment = 'BUILDING' and o_orderdate < date '1995-03-15' and l_shipdate > date '1995-03-15' group by o_orderkey, o_orderdate, o_shippriority order by revenue desc, o_orderdate; " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-4----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-4----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select o_orderpriority, count (distinct o_orderkey) as order_count from hive.paper.lineitem_1 where o_orderdate >= date '1993-07-01' and o_orderdate < date '1993-07-01' + interval '3' month and l_commitdate < l_receiptdate group by o_orderpriority order by o_orderpriority; " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-7----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-7----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select sum(l_extendedprice * (1 - l_discount)) as revenue, s_n_name, c_n_name,  extract(year from l_shipdate) as l_year from  hive.paper.lineitem_1 where ((s_n_name = 'FRANCE' and c_n_name = 'GERMANY') or (s_n_name = 'GERMANY' and c_n_name = 'FRANCE')) and l_shipdate between date '1995-01-01' and date '1996-12-31' group by s_n_name, c_n_name, extract(year from l_shipdate) order by s_n_name, c_n_name, extract(year from l_shipdate); " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-8----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-8----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select o_year, sum(case when nation = 'BRAZIL' then volume else 0 end) / sum(volume) as mkt_share from ( select extract(year from o_orderdate) as o_year, l_extendedprice * (1-l_discount) as volume,  s_n_name as nation from hive.paper.lineitem_1 where c_r_name = 'AMERICA' and o_orderdate between date '1995-01-01' and date '1996-12-31' and p_type = 'ECONOMY ANODIZED STEEL' ) as all_nations group by o_year order by o_year; " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-10----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-10----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select c_custkey, c_name, sum(l_extendedprice * (1 - l_discount)) as revenue, c_acctbal, c_n_name, c_address, c_phone, c_comment from hive.paper.lineitem_1 where o_orderdate >= date '1993-10-01' and o_orderdate < date '1993-10-01' + interval '3' month and l_returnflag = 'R' group by c_custkey, c_name, c_acctbal, c_phone, c_n_name, c_address, c_comment order by revenue desc limit 20; " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-16----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-16----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select  p_brand,  p_type, p_size,  count(distinct s_suppkey) as supplier_cnt from  hive.paper.lineitem_1 where  p_brand <> 'Brand#45'  and p_type not like 'MEDIUM POLISHED%'  and p_size in (49, 14, 23, 45, 19, 3, 36, 9)  and s_comment not like '%Customer%Complaints%' group by p_brand, p_type, p_size order by supplier_cnt desc, p_brand, p_type, p_size; " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-18----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-18----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_quantity) from hive.paper.lineitem_1 group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice having sum(l_quantity) > 300 order by o_totalprice desc, o_orderdate; " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-19----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-19----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select sum(l_extendedprice * (1 - l_discount) ) as revenue from hive.paper.lineitem_1 where ( p_brand = 'Brand#12' and p_container in ( 'SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') and l_quantity >= 1 and l_quantity <= 1 + 10 and p_size between 1 and 5 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON' ) or ( p_brand = 'Brand#23' and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') and l_quantity >= 10 and l_quantity <= 10 + 10 and p_size between 1 and 10 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON' ) or ( p_brand = 'Brand#34' and p_container in ( 'LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') and l_quantity >= 20 and l_quantity <= 20 + 10 and p_size between 1 and 15 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON' ); " &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 

for i in 1 2 3 4
do 
        echo "-------------------------------------------QUERY-21----------------------------------------------------------------">><$PATH>
        echo "-------------------------------------------QUERY-21----------------------------------------------------------------"
	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$PATH>
	bin/drill-conf <<< "select s_name, count(*) as numwait from hive.paper.lineitem_1 l1 where l1.o_orderstatus = 'F' and l1.l_receiptdate > l1.l_commitdate and l1.s_n_name = 'SAUDI ARABIA' and exists ( select  * from hive.paper.lineitem_1 l2 where l2.o_orderkey = l1.o_orderkey and l2.s_suppkey <> l1.s_suppkey ) and not exists ( select * from hive.paper.lineitem_1 l3 where l1.o_orderkey = l3.o_orderkey and l1.s_suppkey <> l3.s_suppkey and l3.l_receiptdate > l3.l_commitdate ) group by s_name order by numwait desc, s_name;" &>> <$PATH>
	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$PATH>
done
echo 'FIM' 
