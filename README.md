# Malicious URL Data Analysis

# Project Summary
In this scenario, acting as a cybersecurity analyst within a Security Operations Center (SOC), I am analyzing a given dataset focused on incoming web traffic in check of malicious urls and its associated servers on behalf of a company. As part of my analysis, I worked on a dataset that combines real-world data and randomly generated data, to uncover critical business insights.

In this project, I investigated key areas of the incoming URLs from the dataset, including:

- 	Source and remote app bytes
- 	DNS and TCP conversations (count of times)
- 	Malicious URL Growth Trends
- 	Marketing channel effectiveness
- 	Country and Server Statistics 
- 	URL Length and Special Characters


I also analyzed the effectiveness of PulseBuy's newly launched loyalty program, assessing its impact on these key areas ultimately offering recommendations for its future.


To derive actionable insights, I utilized a range of tools and techniques, including SQL for data querying and Pandas in Python for statistical analysis and data manipulation. I created dashboards for visual storytelling and employed pivot tables with conditional formatting for advanced analysis. Aggregation functions and statistical techniques were essential for summarizing the results, which I would present to the security and management teams to guide their decision-making and strategy.


- **Part 1: Trends**

Utilizing Excel, I conducted a comprehensive analysis of web traffic trends to extract key insights for the cybersecurity team. This analysis revealed seasonal patterns in malicious URL attempts, year-over-year fluctuations in threat frequency, and variations in attack vectors used against our servers.

- **Part 2: Targeted Insights**

Employing SQL, I derived targeted insights tailored for the cybersecurity and risk management teams. This involved an in-depth examination of malicious URL behaviors, monitoring incident response times, and identifying the most frequent sources of attacks. Notably, I pinpointed the URLs associated with the highest risk levels and analyzed regional attack trends for key vulnerabilities.

  
- **Part 3: Data Analysis (Python)**

I leveraged Pandas in Python to perform advanced statistical analysis and efficiently manipulate large datasets. This facilitated data cleaning and transformation, calculation of summary statistics, and identification of correlations among various metrics, including incident counts. The aggregation functions in Pandas were instrumental in uncovering hidden patterns, such as trends in URL threats and fluctuations in server vulnerabilities over time.


  
- **Part 4: Visualizations**

I utilized Tableau to develop interactive dashboards, enabling the cybersecurity and risk management teams to monitor critical metrics, including threat trends, patterns, and overview. These dashboards were also accessible to other teams to facilitate ongoing monitoring of security performance.

  
- **Part 5: Recommendations & Next Steps**

Points to consider for future review and improvement.
  

The dataset I will be utilizing is a table, encompassing details related to URLs, Servers, registered dates, bytes, and type of maliciousness.


<img width="494" alt="image" src="https://github.com/user-attachments/assets/7505cae1-bea4-41d9-b468-88f2621601de">




# Executive Summary

### Overview of Findings

The analysis uncovers several critical trends for stakeholders to consider. Firstly, there is a notable rise in malicious URL attempts, highlighting an urgent need for enhanced cybersecurity measures to address the evolving threat landscape. Additionally, significant regional variations in the sources of these malicious URLs indicate that tailored defense strategies are essential to account for geographical risk factors. Furthermore, discrepancies in server performance metrics reveal opportunities for optimization, which could strengthen overall network security. By refining incident response strategies and implementing continuous monitoring initiatives, organizations can better protect their assets and maintain a robust cybersecurity posture in a rapidly changing environment.


# Insights Deep Dive
### Part 1: Trends (Excel):

### Yearly:


- 	Application Bytes: Highest recorded volume of 54,385 in 2000, indicating a significant surge in activity related to potentially malicious exploits.
  
- 	Remote Application Packets: Maximum of 422 packets in 2000, highlighting a heightened frequency of incoming requests, possibly from malicious sources attempting to exploit vulnerabilities.
  
- 	DNS Query Times: Total of 217 DNS queries, reflecting increased attempts to resolve malicious URLs, indicating potential strategies to redirect or obfuscate harmful content.

### TCP Ports:


- 	TCP Port 0: Highest traffic activity with 151,915 application bytes, indicating potential malicious activity; often reserved for testing.
  
- 	TCP Port 18: Unusual spike in application bytes at 20,074, raising concerns about exploit attempts or data exfiltration; associated with the Message Send Protocol (MSP).
  
- 	DNS Query Counts: 217 queries suggest ongoing attempts to resolve harmful domain names, indicating efforts by malicious actors to maintain persistence and evade detection.

### Geographical Server Distribution:


- 	Server Types: Apache and Nginx are prevalent, have multiple instances suggesting possible widespread exploitation or targeting.
  
- 	Brazil (BR): Two URLs show an average content length of 20,377 bytes, indicating potential malicious activity. This traffic involved eight unique remote IPs and 38 TCP conversation exchanges. Additionally, a server located in Marrakesh has one URL with an average content length of 13,650 bytes, but it exhibited minimal interaction with remote IPs and TCP ports, suggesting limited activity and a lower risk profile.
  
- 	Germany (DE) 1 URL showed 526 bytes content length with no remote IPs; suggests possible inactive or abandoned sites.
  
- 	United States (US) 51 URLs with a significant average content length of 3,640 bytes and a high count of 2,436 remote IPs, demonstrating extensive malicious activity; 635 DNS queries recorded show ongoing monitoring efforts.





After cleaning and analyzing the findings by making use of Pivot Tables, conditional formatting, aggregation functions, and statistics analysis, the results are summarized to the management and security teams.

Below is an example of a pivot table applied to try to gain insight about “Malicious URL Growth Trends”:


<img width="1461" alt="Screenshot 2024-10-10 120402" src="https://github.com/user-attachments/assets/1c2f3470-d7dc-45fa-b742-165666d07e31">
























### Part 2: Targeted Insights (SQL):

### Growth Trends:


- 	The year 2008 exhibited the highest growth rate of 2066.67% in the number of URLs detected, despite a sharp decline in the average APP_BYTES, which dropped to 82.57.
  
- 	In 1999, there were 2 URLs recorded, representing a 100% growth rate, yet the average APP_BYTES fell to 954, suggesting potential variability in malicious characteristics.
  
### Connection Metrics:


- 	The TCP_CONVERSATION_EXCHANGE metric showed a substantial rise, particularly in 2000, with a total of 372 exchanges, reflecting an 1140% growth rate.
  
- 	Conversely, 2009 witnessed an 86.15% decline in URL counts, while still exhibiting a remarkable 1599.18% growth in the average TCP exchanges, indicating possible adaptation or diversification in malicious URL strategies.



### Server:


- 	Apache: Average of 86.85 for URL length, 3424.77 for content length, and 1133.35 for application bytes, with an average of 12.49 application packets. This indicates a robust web server performance, commonly used by large sites, but a high content length could also suggest potential security vulnerabilities or malicious intent in certain contexts.
  
- nginx: Average of 37.98 for URL length, 970.82 for content length, and 1777.02 for application bytes, averaging 20.80 application packets. This suggests efficient handling of requests typical of high-traffic sites, though the relatively lower URL length could indicate simpler, potentially less sophisticated applications.


In this analysis, I utilized SQL and SQLite. Specifically, I employed aggregation functions, window functions, joins, filtering techniques, CASE expressions, common table expressions (CTEs), and occasionally the QUALIFY clause with row_number() to refine the results.

Below is an example of a query clause showcasing the relationship between the number of special characters (NUMBER_SPECIAL_CHARACTERS) and different URL character encodings (CHARSET):


```sql
/* This query investigates the relationship between the number of special characters (NUMBER_SPECIAL_CHARACTERS)
and different character encodings (CHARSET), providing insights into encoding behavior.*/
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
```



### Part 3: Data Analysis (Python):


- There is a certain URL that has a Moderate DNS query time (2.5-5) generally indicating normal or slightly elevated DNS activity, which typically indicates case usages such as regular web browsing, app usage, or accessing common services. However, this specified URL has a count of 1200 of TCP conversation exchanges, an outlier within the dataset, which may indicate certain malicious behavior such as DDoS attacks, botnets, or data exfiltration. It should be noted that further investigations should be made on the volume of bytes and server communicating.

-  Significant Increase in Malicious URLs: The year 2008 saw a dramatic spike in malicious URLs, with a count peaking at 65, signaling a surge in cyber threats. This rise can be linked to the global financial crisis (2007-2010), which drove more users online, attracting cybercriminals; the rapid growth of social media, offering new platforms for malicious links; and increased public awareness of cybersecurity threats, prompting more sophisticated attack strategies.

In this section, I primarily used Python with Jupyter Notebook, leveraging various libraries to facilitate data analysis and visualization. I utilized pandas for data manipulation and numpy for numerical operations. For statistical modeling, I employed statsmodels, while scipy provided a range of statistical functions. To create compelling visualizations, I used matplotlib and seaborn. The following imports reflect the libraries used in this analysis:


Here is a code snippet that shows next month’s projected sales for each item: 

```python

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
from scipy.stats import norm


 # 1. Scatter plot for URL length vs. Number of special characters
plt.figure(figsize=(10, 6))
sns.scatterplot(data=df, x='URL_LENGTH', y='NUMBER_SPECIAL_CHARACTERS', hue='MAL_TYPE', palette='coolwarm')
plt.title('URL Length vs. Number of Special Characters')
plt.xlabel('URL Length')
plt.ylabel('Number of Special Characters')
plt.legend(title='Malicious Type')
plt.grid(True)
plt.show()

```

![image](https://github.com/user-attachments/assets/562bb890-d792-4832-9f1f-ed2bd5bb58dc)


  
### Part 4: Visualizations (Tableau):

-  In the “Average Malicious URL Country Annually” heatmap, we can see that the 6 countries recorded with the highest rates are - UY: Uruguay, USA: United States of America, PK: Pakistan, UG: Uganda, KR: South Korea (Republic of Korea), and UA: Ukraine.
  
-  TH (Thailand), BE (Belgium), and CY (Cyprus), are considered to be the top 3 countries who have the highest average in count of remote ip connections.  It suggests that these countries have a robust digital economy, with many users engaging in online services, however, higher remote IP connections increase exposure to cyber threats, including DDoS attacks, unauthorized access attempts, and malware propagation. More connections create more potential entry points for cybercriminals.
  
-  High average TCP and DNS exchanges in servers like codfw.wmnet, www.lexisnexis.com, and SSWS indicate increased traffic and potential exposure to cyber threats, with warning signs including unusual spikes in traffic or connection attempts. This necessitates robust monitoring and security measures to mitigate risks associated with potential attacks and performance issues.
  
-  The Apache server's low average source app bytes and oddly high average remote app bytes suggest potential data exfiltration or misconfiguration, indicating a dangerous situation that warrants immediate investigation and enhanced security measures.




In this section, I primarily utilized Tableau, along with MySQL to create the dataset. The Tableau dashboard includes interactive filters, tables, line graphs, and area charts for comprehensive analysis.

![image](https://github.com/user-attachments/assets/f92db446-c681-45b9-ac62-2e441b61bdfc)

![image](https://github.com/user-attachments/assets/dce4753a-e67e-4ce7-b974-7d3665575aad)



  
- **Part 5: Recommendations & Next Steps**

- Refine Incident Response Strategies: Develop and enhance incident response protocols tailored to the identified vulnerabilities within the dataset. Establish clear guidelines and action plans for responding to incidents related to high-risk URLs, ensuring that the team can effectively mitigate potential threats before they escalate.


- Enhance Threat Detection Protocols: Strengthening threat detection measures is crucial, particularly for URLs exhibiting a higher likelihood of malicious activity. Implementing advanced anomaly detection systems can help identify unusual patterns in web traffic and automatically alert the cybersecurity team, enabling quicker responses to potential threats.


- Implement Regular Monitoring Initiatives: Establish ongoing monitoring initiatives focused on high-risk sources identified during the analysis. Continuous tracking of suspicious IPs and URLs can help detect emerging threats in real-time, allowing the cybersecurity team to act proactively against potential attacks.

 
- Conduct Comprehensive Training for Security Personnel: Invest in training programs for cybersecurity staff to ensure they are equipped with the latest skills and knowledge regarding threat detection and response. Keeping the team informed about current cybersecurity trends and techniques can enhance overall security posture.
  
- Evaluate Server Configurations for Security Vulnerabilities: Perform thorough audits of server configurations, particularly for Apache servers displaying low average source app bytes and high remote app bytes. Identifying misconfigurations or vulnerabilities will help reduce the risk of data exfiltration and improve overall security.


