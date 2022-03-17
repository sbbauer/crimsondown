#' Creates an R Markdown PDF Thesis document
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify using the Harvard LaTeX template and cls files.
#'
#' @export
#' @param ... other arguments to bookdown::pdf_book
#' @return A modified \code{pdf_document} based on Harvard guidelines
#' @import bookdown
#' @examples
#' \dontrun{
#'  output: crimsondown::thesis_pdf
#' }
thesis_pdf <- function(...){

  base <- bookdown::pdf_book(template = "template.tex",
                             keep_tex = TRUE,
                             pandoc_args = c("--top-level-division=chapter"),
                             ...)

  # Mostly copied from knitr::render_sweave
  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$fig.align <- "center"

  old_opt <- getOption("bookdown.post.latex")
  options(bookdown.post.latex = fix_envs)
  on.exit(options(bookdown.post.late = old_opt))

  base

}

#' Creates an R Markdown PDF Thesis chapter
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify using the Harvard LaTeX template and cls files.
#'
#' @export
#' @param ... other arguments to bookdown::pdf_book
#' @return A modified \code{pdf_document} for a single thesis chapter
#' @import bookdown
#' @examples
#' \dontrun{
#'  output: crimsondown::chapter_pdf
#' }
chapter_pdf <- function(...){

  base <- bookdown::pdf_book(template = "template_chapter.tex",
                             keep_tex = TRUE,
                             ...)

  # Mostly copied from knitr::render_sweave
  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$fig.align <- "center"

  old_opt <- getOption("bookdown.post.latex")
  options(bookdown.post.latex = fix_envs)
  on.exit(options(bookdown.post.late = old_opt))

  base

}

#' Creates an R Markdown gitbook Thesis document
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify the creation of a webpage version of the thesis.
#'
#' @param ... other arguments to bookdown::gitbook
#' @export
#' @return A gitbook webpage
#' @import bookdown
#' @examples
#' \dontrun{
#'  output: crimsondown::thesis_gitbook
#' }
thesis_gitbook <- function(...){

  base <- gitbook(
    split_by = "none",
    config = list(toc = list(collapse = "section",
                             before = '<li><a href="./"></a></li>',
                             after = '<li><a href="https://github.com/rstudio/bookdown" target="blank">Published with bookdown</a></li>',
                             ...)
    )
  )

  # Mostly copied from knitr::render_sweave
  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$fig.align <- "center"

  base

}


#' Creates an R Markdown Word Thesis chapter that can be read back into R markdown
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify the creation of a Microsoft Word version of the chapter using the redoc package.
#' Very very preliminary.
#' @param ... other arguments to  bookdown::word_document2
#' @seealso \url{https://noamross.github.io/redoc/} for more about the redoc package
#' @export
#' @return A Word Document somewhat based on the guidelines, but needs manual editing.
#' @examples
#' \dontrun{
#'  output: crimsondown::chapter_redoc
#' }
chapter_redoc <- function(...){

  base <- redoc::redoc(...,
                       wrappers = list(redoc::latexwrap, redoc::citationwrap,
                                       redoc::rawblockwrap, redoc::rawspanwrap),
                       reference_docx = "template_chapter.docx")


  base

}

#' Creates an R Markdown Word Thesis document with more formatting options
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify the creation of a Microsoft Word version of the thesis using the officedown package.
#' @param ... other arguments to bookdown::word_document2
#' @seealso \url{https://github.com/davidgohel/officedown} for more about the officedown package
#' @import bookdown
#' @export
#' @return A Word Document somewhat based on the guidelines, but needs manual editing.
#' @examples
#' \dontrun{
#'  output: crimsondown::thesis_word
#' }
thesis_word <- function(...){


  base <- bookdown::markdown_document2(base_format = "officedown::rdocx_document",
                                       ...,
                                       reference_docx = "template.docx")

  base

}


#' Creates an R Markdown Word Thesis chapter with more formatting options
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify the creation of a Microsoft Word version of the thesis using the officedown package.
#' @param ... other arguments to bookdown::word_document2
#' @seealso \url{https://github.com/davidgohel/officedown} for more about the officedown package
#' @import bookdown
#' @export
#' @return A Word Document of a single chapter
#' @examples
#' \dontrun{
#'  output: crimsondown::chapter_word
#' }
chapter_word <- function(...){


  base <- bookdown::markdown_document2(base_format = "officedown::rdocx_document",
                                       ...,
                                       reference_docx = "template_chapter_od.docx")

  base

}

#' Creates an R Markdown epub Thesis document
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify the creation of a epub version of the thesis.
#'
#' @param ... other arguments to bookdown::epub_book
#' @import bookdown
#' @export
#' @return A ebook version of the thesis
#' @examples
#' \dontrun{
#'  output: crimsondown::thesis_epub
#' }
thesis_epub <- function(...){

  base <- epub_book(...)

  # Mostly copied from knitr::render_sweave
  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$fig.align <- "center"

  base

}

fix_envs = function(x){
  beg_reg <- '^\\s*\\\\begin\\{.*\\}'
  end_reg <- '^\\s*\\\\end\\{.*\\}'
  i3 = if (length(i1 <- grep(beg_reg, x))) (i1 - 1)[grepl("^\\s*$", x[i1 - 1])]

  i3 = c(i3,
         if (length(i2 <- grep(end_reg, x))) (i2 + 1)[grepl("^\\s*$", x[i2 + 1])]
  )
  if (length(i3)) x = x[-i3]
  x
}
