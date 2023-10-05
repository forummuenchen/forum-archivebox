library(tidyverse)
library(WikidataQueryServiceR)

query <- '
SELECT DISTINCT ?item ?itemLabel ?itemDescription ?url WHERE {
  { ?item (wdt:P31/(wdt:P279*)) wd:Q64606659. }
  UNION
  { ?item (wdt:P31/(wdt:P279*)) wd:Q61710689. }
    UNION
  { ?item (wdt:P31/(wdt:P279*)) wd:Q105321449. }
  ?item wdt:P856 ?url
  SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
}
ORDER BY (?itemLabel)
'

websites <- query_wikidata(query)

writeLines(websites$url, "data/urls.txt")
writeLines(websites %>% filter(str_detect(url, "forum|letra|museum|sub|muenchen")) %>% pull(url), "data/urls_test.txt")
