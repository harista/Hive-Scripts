# Hive-Scripts
1.0 Flight Delay Records
=======

There are two datasets for this project.

a) The first dataset has on-time flight performance data from 2008. This data comes from originally from RITA.
Link:
http://stat-computing.org/dataexpo/2009/2008.csv.bz2

b) The second dataset lists the aiport codes.
It can be downloaded from my git repository. 
Filename: airports.csv
  
Hive Commands
===

* Upload dataset 2008.csv into HDFS using Ambari Hive interface or using hive shell.

<pre>
<code>

Table name: flight_info
column variables (using delimiter ','): 

   year INT,
   month INT,
   day INT,
   day_of_week INT,
   dep_time INT,
   crs_dep_time INT,
   arr_time INT,
   crs_arr_time INT,
   unique_carrier STRING,
   flight_num INT,
   tail_num STRING,
   actual_elapsed_time INT,
   crs_elapsed_time INT,
   air_time INT,
   arr_delay INT,
   dep_delay INT,
   origin STRING,
   dest STRING,
   distance INT,
   taxi_in INT,
   taxi_out INT,
   cancelled INT,
   cancellation_code STRING,
   diverted INT,
   carrier_delay STRING,
   weather_delay STRING,
   nas_delay STRING,
   security_delay STRING,
   late_aircraft_delay STRING
</code>
</pre>

* Upload dataset airports.csv into HDFS the same way. (Use Ambari interface or CLI)

<pre>
<code>

Table name: aiports
column variables (using delimiter ','):

   name STRING,
   country STRING,
   area_code INT,
   code STRING
</code>
</pre>

* Ensure the table got created and loaded fine:

<pre>
<code>

SHOW TABLES;
SELECT * FROM flight_info
LIMIT 100;

</code>
</pre>

* Now let us Query the table. Will find average arrival delay for all flights departing John F Kennedy International (ie origin='JFK) aiport in March (ie month=3):

<pre>
<code>
SELECT name, avg(arr_delay) as avgdelay
FROM flight_info f JOIN airports a ON f.origin=a.code
WHERE month=3 AND a.code='JFK'
GROUP by name;

Result:

name	                        avgdelay
John F Kennedy International	12.093309509628748
</code>
</pre>

* Will write another script which can find which airport had highest number of flights departed. 

<pre>
<code>
SELECT name, COUNT(f.origin) AS totalcount
FROM flight_info f INNER JOIN airports a ON (f.origin=a.code)
GROUP BY name
ORDER BY totalcount
DESC;

Result:

name	                                      totalcount
Hartsfield-Jackson Atlanta International	  414513
Chicago O'hare International	              350380
Dallas/Fort Worth International	            281281
Denver International	                      241443
Los Angeles International	                  215608
Phoenix Sky Harbor International Airport	  199408
George Bush Intercontinental	              185172
Mc Carran International	                    172876
Detroit Metropolitan Wayne County	          161989
</code>
</pre>
