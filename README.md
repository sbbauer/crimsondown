# ustandown

Based on the crimsondown package by Louisa H Smith (https://github.com/louisahsmith/crimsondown) the appropriate files have been modified to suit the requirements for a doctoral thesis at the University of St Andrews. Original README below:

# crimsondown

This project builds directly off Chester Ismay's [`thesisdown`](https://github.com/ismayc/thesisdown) package, which uses the [`bookdown`](https://github.com/rstudio/bookdown) package to support the writing of theses meeting certain style requirements. This implementation attempts to conform to [Harvard University Graduate School of Arts and Sciences formatting requirements](https://gsas.harvard.edu/degree-requirements/dissertations/formatting-your-dissertation), which had previously been translated to LateX by [Michael Kolesár](https://github.com/kolesarm/harvard-gsas-thesis). It was also influenced by Ben Marwick's [`huskydown`](https://github.com/benmarwick/huskydown). A list of other schools for which thesisdown related packages are available can be found [here](https://github.com/ismayc/thesisdown#customizing-thesisdown-to-your-institution).

Currently, the PDF and gitbook versions are fully functional.  The word version has a template that somewhat matches the formatting requirements but needs manual editing. It uses the [`officedown`]() package for more flexibility. There's also an epub version which is exactly cloned from the thesisdown original.

New to this package are the `chapter_` output formats, designed for drafting chapters without dealing with all the front matter and fancy formatting. The `.Rmd` files can just be copied from a chapter folder to the full document folder when you're ready to render the whole thing. Both pdf and word versions are available, as is a version that uses the [`redoc`](https://noamross.github.io/redoc/) package to output word documents. The goal of this is to make going back and forth between RMarkdown and Word easier. I have no idea if it will work or be useful here. 

Although you might want to start off with just a chapter, you should first go through the whole thesis template to see how it works, as there is a lot of documentation in the template files. The instructions below will walk you through this. 

# Using crimsondown to write your dissertation

The text in this section builds off the [README of the `huskydown` package](https://github.com/benmarwick/huskydown/blob/master/README.md) and [that of the `thesisdown` package](https://github.com/ismayc/thesisdown/blob/master/README.md).

Using `crimsondown` has some prerequisites which are described below. To compile PDF documents using **R**, you are going to need to have LaTeX installed. By far the easiest way to install LaTeX on any platform is with the [tinytex](https://yihui.name/tinytex/) R package:

```{r}
install.packages(c('tinytex', 'rmarkdown'))
tinytex::install_tinytex()
# after restarting RStudio, confirm that you have LaTeX with 
tinytex:::is_tinytex() 
```

When you first attempt to compile a pdf using `rmarkdown` or `bookdown`, `tinytex` will install a number of LaTeX packages for you. Occasionally you may want to do so manually. Here is one such example of how to do so:

```{r}
tinytex::tlmgr_install("babel-portuges")
```

To use `crimsondown` from [RStudio](http://www.rstudio.com/products/rstudio/download/):

1) Ensure that you have already installed LaTeX and the fonts described above, and are using the latest version of [RStudio](http://www.rstudio.com/products/rstudio/download/). You can use `thesisdown` without RStudio. For example, you can write the Rmd files in your favourite text editor (e.g. [Atom](https://atom.io/), [Notepad++](https://notepad-plus-plus.org/)). But RStudio is probably the easiest tool for writing both R code and text in your thesis. It also provides a nice way to build your thesis while editing. We'll proceed assuming that you have decided to use the RStudio workflow.

2) Install the `bookdown` and `crimsondown` packages. Note that `crimsondown` is not available on CRAN and that's why `install.packages("crimsondown")` won't work. Use `remotes::install_github()` as shown below instead to install the package.

```r
if (!require("remotes")) install.packages("remotes", repos = "http://cran.rstudio.org")
remotes::install_github("rstudio/bookdown")
remotes::install_github("louisahsmith/crimsondown")
```

3) In RStudio, start a new project from the File menu or the upper-right corner of the window. This is not strictly necessary but will make your life easier. Call it whatever you want. Then create a new RMarkdown file. Choose 'From Template' and then 'Thesis' from the `{crimsondown}` package. Name it `index`.

4. This will create a folder called `index` inside your project directory. Move everything in that folder up one folder, into the main project directory. You can then delete the empty `index` directory.

5. You should see various `.Rmd` files. Open `index.Rmd`. This is where you will enter your information -- your name, thesis title, advisor's name, etc. -- and can change some formatting options if you desire. 


### Day-to-day writing of your thesis 

You need to edit the individual chapter R Markdown files to write your thesis. If you want to work on them completely separate from the rest of the document, choose the "chapter" template to work on a chapter at a time. When you're ready, you can move the files into the thesis directory.

It's recommended that you version control your thesis using GitHub if possible. RStudio can also easily sync up with GitHub to make the process easier. While writing, you should `git commit` your work frequently, after every major activity on your thesis. For example, every few paragraphs or section of text, and after major step of analysis development. You should `git push` at the end of each work session before you leave your computer or change tasks. For a gentle, novice-friendly guide to getting starting with using Git with R and RStudio, see <http://happygitwithr.com/>.

## Rendering

The compiled thesis files will be deposited in the `_book/` directory, by default.

## Components

The following components are ones you should edit to customize your thesis:

### `_bookdown.yml`

This is the main configuration file for your thesis. It determines what Rmd files are included in the output, and in what order. Arrange the order of your chapters in this file and ensure that the names match the names in your folders. 

### `index.Rmd`

This file contains all the meta information that goes at the beginning of your
document. You'll need to edit this to put your name on the first page, the title of your thesis, etc.

### `01-chap1.Rmd`, `02-chap2.Rmd`, etc.

These are the Rmd files for each chapter in your dissertation. Write your thesis in these. If you're writing in RStudio, you may find the [wordcount addin](https://github.com/benmarwick/wordcountaddin) useful for getting word counts and readability statistics in R Markdown documents.

### `bib/`

Store your bibliography (as bibtex files) here. We recommend using the [citr addin](https://github.com/crsh/citr) and [Zotero](https://www.zotero.org/) or [Mendeley](https://www.mendeley.com/) to efficiently manage and insert citations. 

### `csl/`

Specific style files for bibliographies should be stored here. A good source for
citation styles is https://github.com/citation-style-language/styles#readme

### `figure/` and `data/`

Store your figures and data here and reference them in your R Markdown files. See the [bookdown book](https://bookdown.org/yihui/bookdown/) for details on cross-referencing items using R Markdown.
