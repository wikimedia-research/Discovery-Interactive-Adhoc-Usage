caches = Usage_cache Interactions_cache
.PHONY : clean

days?=90

clean :
	rm -rf $(caches)
usage : Usage.Rmd
	R -e "rmarkdown::render('Usage.Rmd')"
interactions : Interactions.Rmd
	R -e "rmarkdown::render('Interactions.Rmd', params=list(days = ${days}))"
