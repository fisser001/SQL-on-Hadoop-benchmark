#!/bin/bash

echo 'QUERY1-STARTING'

echo "------------------------------------------------------------QUERY-1-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select l_returnflag, l_linestatus, sum(l_quantity) as sum_qty, sum(l_extendedprice) as sum_base_price, sum(l_extendedprice*(1-l_discount)) as sum_disc_price, sum(l_extendedprice*(1-l_discount)*(1+l_tax)) as sum_charge, avg(l_quantity) as avg_qty, avg(l_extendedprice) as avg_price, avg(l_discount) as avg_disc, count(*) as count_order from lineitem_1 where l_shipdate <= date '1998-12-01' - interval '90' day group by l_returnflag, l_linestatus order by l_returnflag, l_linestatus;"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY1-DONE'

echo 'QUERY3-STARTING'

echo "------------------------------------------------------------QUERY-3-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select o_orderkey, sum(l_extendedprice*(1-l_discount)) as revenue, o_orderdate, o_shippriority from lineitem_1 where c_mktsegment = 'BUILDING' and o_orderdate < date '1995-03-15' and l_shipdate > date '1995-03-15' group by o_orderkey, o_orderdate, o_shippriority order by revenue desc, o_orderdate;"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY3-DONE'

echo 'QUERY4-STARTING'

echo "------------------------------------------------------------QUERY-4-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select o_orderpriority, count (distinct o_orderkey) as order_count from lineitem_1 where o_orderdate >= date '1993-07-01' and o_orderdate < date '1993-07-01' + interval '3' month and l_commitdate < l_receiptdate group by o_orderpriority order by o_orderpriority;"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY4-DONE'

echo 'QUERY7-STARTING'

echo "------------------------------------------------------------QUERY-7-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select sum(l_extendedprice * (1 - l_discount)) as revenue, s_n_name, c_n_name,  year(l_shipdate) as l_year from  lineitem_1 where ((s_n_name = 'FRANCE' and c_n_name = 'GERMANY') or (s_n_name = 'GERMANY' and c_n_name = 'FRANCE')) and l_shipdate between date '1995-01-01' and date '1996-12-31' group by s_n_name, c_n_name, year(l_shipdate) order by s_n_name, c_n_name, l_year;"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY7-DONE'

echo 'QUERY8-STARTING'

echo "------------------------------------------------------------QUERY-8-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>


 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select o_year, sum(case when nation = 'BRAZIL' then volume else 0 end) / sum(volume) as mkt_share from ( select year(o_orderdate) as o_year, l_extendedprice * (1-l_discount) as volume, s_n_name as nation from lineitem_1 where c_r_name = 'AMERICA' and o_orderdate between date '1995-01-01' and date '1996-12-31' and p_type = 'ECONOMY ANODIZED STEEL') as all_nations group by o_year order by  o_year;"&>><$results_path>



	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY8-DONE'

echo 'QUERY10-STARTING'

echo "------------------------------------------------------------QUERY-10-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select c_custkey, c_name, sum(l_extendedprice * (1 - l_discount)) as revenue, c_acctbal, c_n_name, c_address, c_phone, c_comment from lineitem_1 where o_orderdate >= date '1993-10-01' and o_orderdate < date '1993-10-01' + interval '3' month and l_returnflag = 'R' group by c_custkey, c_name, c_acctbal, c_phone, c_n_name, c_address, c_comment order by revenue desc limit 20;"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY10-DONE'

echo 'QUERY16-STARTING'

echo "------------------------------------------------------------QUERY-16-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select p_brand,
 p_type,
 p_size,
 count(distinct s_suppkey) as supplier_cnt from
 lineitem_1 where
  p_brand <> 'Brand#45' and p_type not like 'MEDIUM POLISHED%'
 and p_size in (49, 14, 23, 45, 19, 3, 36, 9)
 and s_comment not like '%Customer%Complaints%'
 group by p_brand,
 p_type,
 p_size order by
 supplier_cnt desc,
 p_brand,
 p_type, p_size;"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY16-DONE'

echo 'QUERY18-STARTING'

echo "------------------------------------------------------------QUERY-18-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_quantity) from lineitem_1 group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice having sum(l_quantity) > 300 order by o_totalprice desc, o_orderdate;"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY18-DONE'

echo 'QUERY19-STARTING'

echo "------------------------------------------------------------QUERY-19-------------------------------------------------------">><$results_path>

for i in 1 2 3 4

do 

        echo "-------------------------------------------------------------------------------------------------------------------">><$results_path>

	echo "--------------------------------------------RUN-"$i"---------------------------------------------------------------">><$results_path>

 	beeline -u 'jdbc:hive2://<$server:$port>/<$path> hive hive' -e "select sum(l_extendedprice * (1 - l_discount) ) as revenue from lineitem_1 where ( p_brand = 'Brand#12'and p_container in ( 'SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') and l_quantity >= 1 and l_quantity <= 1 + 10 and p_size between 1 and 5 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON') or (p_brand = 'Brand#23' and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') and l_quantity >= 10 and l_quantity <= 10 + 10 and p_size between 1 and 10 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON' ) or (p_brand = 'Brand#34' and p_container in ( 'LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') and l_quantity >= 20 and l_quantity <= 20 + 10 and p_size between 1 and 15 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON');"&>><$results_path>

	echo "-------------------------------------------FIM-RUN-"$i"------------------------------------------------------------">><$results_path>

done

echo 'QUERY19-DONE'
