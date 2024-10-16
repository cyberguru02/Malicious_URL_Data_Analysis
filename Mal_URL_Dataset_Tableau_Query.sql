SELECT 
    mal_web_traffic.id AS traffic_id,
    mal_web_traffic.url,
    mal_web_traffic.url_length,
    mal_web_traffic.number_special_characters,
    mal_web_traffic.charset,
    mal_web_traffic.server_info,
    mal_web_traffic.server_info_cleaned,
    mal_web_traffic.content_length,
    mal_web_traffic.whois_country,
    mal_web_traffic.whois_country_cleaned,
    mal_web_traffic.whois_statepro,
    mal_web_traffic.whois_regdate,
    mal_web_traffic.whois_regdate_cleaned,
    mal_web_traffic.whois_regdate_month,
    mal_web_traffic.whois_regdate_year,
    mal_web_traffic.whois_updated_date,
    mal_web_traffic.tcp_conversation_exchange,
    mal_web_traffic.dist_remote_tcp_port,
    mal_web_traffic.remote_ips,
    mal_web_traffic.app_bytes,
    mal_web_traffic.source_app_packets,
    mal_web_traffic.remote_app_packets,
    mal_web_traffic.source_app_bytes,
    mal_web_traffic.remote_app_bytes,
    mal_web_traffic.app_packets,
    mal_web_traffic.dns_query_times,
    mal_web_traffic.mal_type
FROM 
    mal-613259.mal_web_traffic AS mal_web_traffic
