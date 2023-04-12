# PhilSaDataCamp-Codia

This is my entry for Philippine Space Agency's Data Camp and 5-day Workshop on processing geospatial data using Python, GeoPandas, and Google Colab. My project won as the best proposal. The show-and-tell session can be watched <a href="https://www.youtube.com/watch?v=xQIUxWZdgsI&feature=share&utm_source=EKLEiJECCKjOmKnC5IiRIQ&t=2679">here</a>.

This repository includes a Python Notebook that showcases my final output after the data camp: a map of rainfall return levels in the Philippines.

# Estimating Rainfall Return Levels in the Philippines

In the Philippines, disasters usually happen due to lack of awareness. One of the reasons that the town leaders mention is "This rainfall intensity has never happened yet", that is why some come unprepared when an extreme natural event occurs. Extreme rainfalls are inevitable, but we can extend the analysis just by asking "how frequent is this extreme rainfall?"

Using the concept of "return levels", I estimated the magnitude of extreme rainfall that happens once every 25 years, once every 50 years, once every 100 years, and so on.

Using the rainfall data extracted from NOAA, probability distribution of annual rainfall maxima is estimated from each of the 55 PAGASA weather stations. Multiple univariate Generalized Extreme Value Distributions (GEVD) was fitted to the data from each station. 

Since not every province have a PAGASA rainfall station, the rainfall magnitude on ungauged areas were also estimated using spatial interpolation (kriging).

The final output is the map of the Philippine provinces with the amount of rainfall per return period, that is, the magnitude of rainfall that happens once every 5 years, once every 10 years, once every 25 years, and so on.



![Return Levels 5 to 50](https://user-images.githubusercontent.com/76110917/192726467-c1706d6b-310c-42f9-96c8-d5c7c84756df.png)
![100 year return level](https://user-images.githubusercontent.com/76110917/192726483-eee23ec9-7e18-4ed0-9a9f-da7f35c992e7.png)


Access the Google Colab notebook here:
https://colab.research.google.com/drive/1Ipp5zpgYoV4GQvz1AQ_a5EKfUmGZl2AO?usp=sharing
