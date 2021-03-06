R in 3 Months: Fall 2021
================

### Sep 16: Welcome

Course assignment

-   Complete Getting Started

Project assignment

-   None

Live session

-   Intros + get to know you
-   Getting Started questions
-   Have previous participants talk about how they felt about learning R

### Sep 23: RMarkdown

Course assignment

-   Fundamentals RMarkdown lessons

Project assignment

-   Create RStudio project
-   Create RMarkdown doc

Live session

### Sep 30: Data wrangling and analysis

Course assignment

-   Fundamentals data wrangling lessons

Project assignment

-   Do some data analysis with your data

Live session

### Oct 7: Data viz

Course assignment

-   Fundamentals data viz lessons

Project assignment

-   Make a graph from your data: it doesn’t matter how beautiful it is!

``` r
library(tidyverse)
msleep %>% 
  count(vore) %>% 
  ggplot(aes(x = vore,
             y = n,
             fill = vore)) +
  geom_col()
```

![](readme_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Live session

### Oct 14: Catch-up week (talk about best practices for their own projects)

Course assignment

-   <https://rstats.wtf/project-oriented-workflow.html>

Project assignment

-   Make your work into a project (if you didn’t already do so)

Live session

-   Discuss project-oriented workflow

### Oct 21: Git + GitHub

Course assignment

-   See [Git + GitHub
    Course](https://www.notion.so/Git-GitHub-Course-a332fb84943f462faee7732c02d378d5)

Project assignment

-   Get GH set up

Live session

-   

### Oct 28: Advanced data wrangling, part 1

Course assignment

-   Going Deeper data wrangling lessons, part 1

Project assignment

-   None

Live session

-   Discuss tidy data

### Nov 4: Advanced data wrangling, part 2

Course assignment

-   Going Deeper data wrangling lessons, part 2

Project assignment

-   Tidy your data

Live session

-   Discuss tidy data

### Nov 11: Catch-up week

Course assignment

-   None

Project assignment

Live session

-   Cool things you can do once you use GitHub (e.g. Netlify)

### Nov 18: Advanced data viz, part 1

Course assignment

-   Going Deeper data viz lessons, part 1

Project assignment

-   None

Live session

### Dec 2: Advanced data viz, part 2

Course assignment

-   Going Deeper data viz lessons, part 2

Project assignment

-   Take a previous plot and improve it

Live session

### Dec 9: Advanced RMarkdown

Course assignment

-   Going Deeper RMarkdown lessons

Project assignment

-   None

Live session

-   Show ways to brand your work

### Dec 16: Final projects

~~Convert your project into some final format~~

People write a short reflection on something that has changed with their
work through learning R

People post one chart they’ve made and we tweet them out

People could knit report and publish to RPubs

David + Charlie highlight cool things people have done

Bring in people from spring 2021 cohort to talk about what they’ve done
with R
