SELECT name, avg(arr_delay) as avgdelay
FROM flight_info f JOIN airports a ON f.origin=a.code
WHERE month=3 AND a.code='JFK'
GROUP by name;
