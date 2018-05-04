# Maps analytics (T170022)

Codebase for the analysis of Maps usage. See [T170022](https://phabricator.wikimedia.org/T170022) for more details.

## Re-run instructions

### R packages

Once [R](https://cran.r-project.org/) is installed on your local machine, launch it and run the following:

```R
install.packages(
  c("rmarkdown", "printr", "tidyverse", "dygraphs", "DT", "data.table", "devtools"),
  repos = c(CRAN = "https://cran.r-project.org")
)

devtools::install_git("https://gerrit.wikimedia.org/r/wikimedia/discovery/wmf", dependencies = c("Depends", "Imports"))
devtools::install_git("https://gerrit.wikimedia.org/r/wikimedia/discovery/polloi", dependencies = c("Depends", "Imports"))
```

### SSH tunnel

Both reports are compiled using [RMarkdown](http://rmarkdown.rstudio.com/), [knitr](https://yihui.name/knitr/), and an open SSH tunnel for connecting to our databases. For the usage report, use the following:

```bash
ssh -N stat6 -L 3307:analytics-store.eqiad.wmnet:3306
```

For the interactions report, you need to open a tunnel to a different host (and a slightly different port):

```bash
ssh -N stat6 -L 3308:db1108.eqiad.wmnet:3306
```

Refer to [wikitech:Production shell access](https://wikitech.wikimedia.org/wiki/Production_shell_access) for details on SSH configuration. These commands assume there is an entry in your ~/.ssh/config for host `stat6` (referring to [stat1006](https://wikitech.wikimedia.org/wiki/Stat1006)), so you may need to change the command depending on your personal configuration.

### Rendering the report

Use the following commands:

- `make clean` clears the caches from the previous run
- `make usage` renders the usage report
- `make interactions` renders the interactions report
  - by default will fetch 90 days of Kartographer EventLogging data
  - use `make days=120 interactions` to have the report fetch 120, for example

`Usage.Rmd` has a YAML header which contains the list of Wikipedias and other Wikimedia projects that have mapframes enabled, and that's what the report refers to when querying the databases.
