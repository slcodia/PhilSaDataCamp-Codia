# PhilSaDataCamp-Codia
Outputs from Philippine Space Agency SIICaP: Data Camp

This includes a Python Notebook that showcases my final output after the data camp: a map of rainfall return levels in the Philippines.


In the Philippines, disasters usually happen due to lack of awareness. One of the reasons that the town leaders mention is "Hindi pa kasi nangyayari 'yung ganito kalakas na ulan", that is why some come unprepared when an extreme natural event occurs. Extreme rainfalls are inevitable, but we can extend the analysis just by asking "how frequent is this extreme rainfall?"

Using the concept of return level, we estimate the magnitude of extreme rainfall that happens once every 25 years, once every 50 years, once every 100 years, and so on.

Using the rainfall data extracted from NOAA, probability distribution of annual rainfall maxima is estimated from each of the 55 PAGASA weather stations. 

Since not every province have a PAGASA rainfall station, we estimate the rainfall magnitude on ungauged areas using spatial interpolation (kriging).

The final output is the map of the Philippine provinces with the amount of rainfall per return period, that is, the magnitude of rainfall that happens once every 5 years, once every 10 years, once every 25 years, and so on.
