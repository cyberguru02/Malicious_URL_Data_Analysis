/* 1. Rank URLs by Content Length Using a Window Function
 This query ranks URLs by CONTENT_LENGTH for each WHOIS_COUNTRY using the RANK() function. */
SELECT 
    WHOIS_COUNTRY, 
    URL, 
    CONTENT_LENGTH, 
    RANK() OVER (PARTITION BY WHOIS_COUNTRY ORDER BY CONTENT_LENGTH DESC) AS content_rank
FROM your_table_name
ORDER BY WHOIS_COUNTRY, content_rank;

/* 2. Calculate Rolling Sum of TCP Conversations by Date
 This query calculates a rolling sum of TCP_CONVERSATION_EXCHANGE using a 3-row window, showing a running total.*/
SELECT 
    URL, 
    WHOIS_REGDATE, 
    TCP_CONVERSATION_EXCHANGE,
    SUM(TCP_CONVERSATION_EXCHANGE) OVER (ORDER BY WHOIS_REGDATE ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS rolling_sum
FROM your_table_name
ORDER BY WHOIS_REGDATE;

/* 3. CTE for URL Length Percentile Calculation
  This CTE calculates percentiles for URL_LENGTH and filters out URLs in the top 10% by length*/
WITH url_length_percentiles AS (
    SELECT 
        URL, 
        URL_LENGTH, 
        PERCENT_RANK() OVER (ORDER BY URL_LENGTH) AS percentile_rank
    FROM your_table_name
)
SELECT URL, URL_LENGTH, percentile_rank
FROM url_length_percentiles
WHERE percentile_rank > 0.90; -- Only URLs in the top 10% by length

/* 4. Lag Function to Compare URL Content-Length Changes Over Time
 This query compares the current CONTENT_LENGTH with the previous record's content length using LAG()*/
SELECT 
    URL, 
    WHOIS_REGDATE, 
    CONTENT_LENGTH,
    LAG(CONTENT_LENGTH, 1) OVER (ORDER BY WHOIS_REGDATE) AS previous_content_length,
    (CONTENT_LENGTH - LAG(CONTENT_LENGTH, 1) OVER (ORDER BY WHOIS_REGDATE)) AS content_change
FROM your_table_name
ORDER BY WHOIS_REGDATE;

/* 5. CTE to Find URL with Max TCP Conversations in Each Country 
This query uses a Common Table Expression (CTE) to rank URLs by their TCP conversation exchanges within each country. It then selects the URL with the highest number of TCP conversations in each country. */
WITH ranked_urls AS (
    SELECT 
        WHOIS_COUNTRY, 
        URL, 
        TCP_CONVERSATION_EXCHANGE,
        ROW_NUMBER() OVER (PARTITION BY WHOIS_COUNTRY ORDER BY TCP_CONVERSATION_EXCHANGE DESC) AS rank
    FROM your_table_name
)
SELECT WHOIS_COUNTRY, URL, TCP_CONVERSATION_EXCHANGE
FROM ranked_urls
WHERE rank = 1;

/* 
6. Running Average of TCP Conversations Over Time 
Use window functions to compute a running average of TCP_CONVERSATION_EXCHANGE over time, which smoothens trends in the data.
This query computes a running average of TCP_CONVERSATION_EXCHANGE over the current row and the previous five rows.
*/
SELECT 
    WHOIS_REGDATE, 
    URL, 
    TCP_CONVERSATION_EXCHANGE,
    AVG(TCP_CONVERSATION_EXCHANGE) OVER (ORDER BY WHOIS_REGDATE ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS running_avg
FROM your_table_name
ORDER BY WHOIS_REGDATE;

/* 
7. CTE to Identify URLs with Continuous High TCP Conversation 
This CTE identifies URLs that have consistently high TCP_CONVERSATION_EXCHANGE over several consecutive time periods.
This query checks if both the current and previous row had a TCP_CONVERSATION_EXCHANGE above a certain threshold, identifying URLs with sustained high activity.
*/
WITH high_tcp_conversations AS (
    SELECT 
        URL, 
        WHOIS_REGDATE, 
        TCP_CONVERSATION_EXCHANGE,
        LAG(TCP_CONVERSATION_EXCHANGE) OVER (ORDER BY WHOIS_REGDATE) AS prev_exchange
    FROM your_table_name
)
SELECT 
    URL, 
    WHOIS_REGDATE, 
    TCP_CONVERSATION_EXCHANGE
FROM high_tcp_conversations
WHERE TCP_CONVERSATION_EXCHANGE > 1000 -- Example threshold
AND prev_exchange > 1000
ORDER BY WHOIS_REGDATE;


/* 
8. Window Function to Calculate Percent Change in Content Length 
This query calculates the percentage change in CONTENT_LENGTH over time using the LAG() function.
It calculates the percentage change in CONTENT_LENGTH compared to the previous row.
*/
SELECT 
    URL, 
    WHOIS_REGDATE, 
    CONTENT_LENGTH, 
    (CONTENT_LENGTH - LAG(CONTENT_LENGTH, 1) OVER (ORDER BY WHOIS_REGDATE)) / LAG(CONTENT_LENGTH, 1) OVER (ORDER BY WHOIS_REGDATE) * 100 AS percent_change
FROM your_table_name
ORDER BY WHOIS_REGDATE;

/* 
9. CTE to Identify Spikes in DNS Query Times 
This CTE finds significant spikes in DNS_QUERY_TIMES where the value is at least twice as large as the previous entry.
It looks for cases where the current DNS_QUERY_TIMES is more than double the previous entry, indicating a possible spike in query times.
*/
WITH dns_spikes AS (
    SELECT 
        URL, 
        WHOIS_REGDATE, 
        DNS_QUERY_TIMES, 
        LAG(DNS_QUERY_TIMES) OVER (ORDER BY WHOIS_REGDATE) AS prev_query_time
    FROM your_table_name
)
SELECT 
    URL, 
    WHOIS_REGDATE, 
    DNS_QUERY_TIMES, 
    prev_query_time
FROM dns_spikes
WHERE DNS_QUERY_TIMES > prev_query_time * 2
ORDER BY WHOIS_REGDATE;

/* 
10. CTE for Identifying URLs with Consistently Low TCP Exchange 
This query identifies URLs that have consistently low TCP exchange rates over a defined period.
It uses a window function to compute the average TCP exchange over the last 5 entries, then filters out URLs where the average exchange is below 100.
*/
WITH low_tcp_exchange AS (
    SELECT 
        URL, 
        WHOIS_REGDATE, 
        TCP_CONVERSATION_EXCHANGE,
        AVG(TCP_CONVERSATION_EXCHANGE) OVER (PARTITION BY URL ORDER BY WHOIS_REGDATE ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS avg_tcp_exchange
    FROM your_table_name
)
SELECT URL, WHOIS_REGDATE, TCP_CONVERSATION_EXCHANGE, avg_tcp_exchange
FROM low_tcp_exchange
WHERE avg_tcp_exchange < 100 -- Threshold for low TCP exchange
ORDER BY WHOIS_REGDATE;






/* 
11. Distribution of Content Length by Server Type 
This query shows the average, minimum, and maximum CONTENT_LENGTH by SERVER_INFO_CLEANED.
It highlights the spread of content sizes handled by different servers.
*/
SELECT 
    SERVER_INFO_CLEANED, 
    AVG(CONTENT_LENGTH) AS avg_content_length, 
    MIN(CONTENT_LENGTH) AS min_content_length, 
    MAX(CONTENT_LENGTH) AS max_content_length
FROM 
    your_table
WHERE 
    CONTENT_LENGTH IS NOT NULL
GROUP BY 
    SERVER_INFO_CLEANED
ORDER BY 
    avg_content_length DESC;

/* 
12. Analyzing Special Character Usage by Charset 
This query investigates the relationship between the number of special characters (NUMBER_SPECIAL_CHARACTERS) 
and different character encodings (CHARSET).
It provides insights into encoding behavior.
*/
SELECT 
    CHARSET, 
    AVG(NUMBER_SPECIAL_CHARACTERS) AS avg_special_chars, 
    MAX(NUMBER_SPECIAL_CHARACTERS) AS max_special_chars, 
    MIN(NUMBER_SPECIAL_CHARACTERS) AS min_special_chars
FROM 
    your_table
GROUP BY 
    CHARSET
ORDER BY 
    avg_special_chars DESC;

/* 
13. Detecting Potential Anomalies in TCP Communication 
This query helps detect potential outliers by showing URLs with an unusually high number 
of TCP conversations (TCP_CONVERSATION_EXCHANGE) compared to the average.
*/
SELECT 
    URL, 
    TCP_CONVERSATION_EXCHANGE, 
    AVG(TCP_CONVERSATION_EXCHANGE) OVER () AS avg_tcp_conversations
FROM 
    your_table
WHERE 
    TCP_CONVERSATION_EXCHANGE > (SELECT AVG(TCP_CONVERSATION_EXCHANGE) * 1.5 FROM your_table)
ORDER BY 
    TCP_CONVERSATION_EXCHANGE DESC;

/* 
14. Finding URLs with Long DNS Query Times 
This query returns URLs that have above-average DNS query times, helping to identify 
which URLs might be slow due to DNS-related delays.
*/
SELECT 
    URL, 
    DNS_QUERY_TIMES
FROM 
    your_table
WHERE 
    DNS_QUERY_TIMES > (SELECT AVG(DNS_QUERY_TIMES) FROM your_table)
ORDER BY 
    DNS_QUERY_TIMES DESC;

/* 
15. Yearly Trend of Registration by Country 
This query tracks the number of domain registrations (WHOIS_REGDATE_YEAR) by country,
providing insights into registration trends over time.
*/
SELECT 
    WHOIS_COUNTRY_CLEANED, 
    WHOIS_REGDATE_YEAR, 
    COUNT(*) AS registration_count
FROM 
    your_table
WHERE 
    WHOIS_REGDATE_YEAR IS NOT NULL
GROUP BY 
    WHOIS_COUNTRY_CLEANED, WHOIS_REGDATE_YEAR
ORDER BY 
    WHOIS_REGDATE_YEAR DESC, registration_count DESC;

/* 
16. Malicious URL Detection by Server Type 
This query calculates the ratio of malicious URLs (MAL_TYPE = 1) to total URLs for each server type 
(SERVER_INFO_CLEANED), helping to identify servers associated with higher risks.
*/
SELECT 
    SERVER_INFO_CLEANED, 
    SUM(CASE WHEN MAL_TYPE = 1 THEN 1 ELSE 0 END) AS malicious_count, 
    COUNT(*) AS total_count,
    (SUM(CASE WHEN MAL_TYPE = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS malicious_ratio
FROM 
    your_table
GROUP BY 
    SERVER_INFO_CLEANED
ORDER BY 
    malicious_ratio DESC;

/* 
17. Remote IP Frequency Analysis 
This query calculates the frequency of REMOTE_IPS that have been recorded in the dataset,
which may help to identify common or suspicious remote IP addresses.
*/
SELECT 
    REMOTE_IPS, 
    COUNT(*) AS ip_count
FROM 
    your_table
GROUP BY 
    REMOTE_IPS
ORDER BY 
    ip_count DESC;

/* 
18. Tracking Large Content Length with High App Bytes 
This query identifies URLs with both large content lengths and high application byte transfer,
which may indicate high resource usage.
*/
SELECT 
    URL, 
    CONTENT_LENGTH, 
    APP_BYTES
FROM 
    your_table
WHERE 
    CONTENT_LENGTH > (SELECT AVG(CONTENT_LENGTH) FROM your_table) 
    AND APP_BYTES > (SELECT AVG(APP_BYTES) FROM your_table)
ORDER BY 
    CONTENT_LENGTH DESC, APP_BYTES DESC;

