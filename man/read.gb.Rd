% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.gb.R
\name{read.gb}
\alias{read.gb}
\title{Opens files with .gb extensions}
\usage{
read.gb(x, DNA = TRUE, Type = "full", Source = "File")
}
\arguments{
\item{x}{character. The name of the file which the data are to be read from, or the character string containing the data. It can contains several records}

\item{DNA}{logical. If TRUE, the DNA sequence in the ORIGIN part will be merged in one character string. If FALSE, the default layout will be kept. Default if TRUE}

\item{Type}{character. Should the output contain FEATURES and REFERENCE parts ? Possible values are "full" for a full record, "nofeat" to ignore FEATURES part, "noref" to ignore REFERENCE part and "nfnr" to ignore both parts. Default is "full"}

\item{Source}{character. If x is a character string, use "Char". If x is a filename use "File". Default is "File"}
}
\value{
Returns a table containing the data
}
\description{
This function opens complete record(s) with .gb extension from the NCBI/GenBank Nucleotide database and returns a list containing shaped record(s). These kind of files contains detailed records of DNA samples (locus, organism, type of sequence, source of the sequence...). An example of record can be found at \url{https://www.ncbi.nlm.nih.gov/nuccore/HE799070}. Records with > 200'000 bp may experience long processing times, especially if they have numerous FEATURES items. Also works for reports obtained with rentrez package.
}
\examples{
\dontrun{
read.gb(File = "sequence.gb", DNA = TRUE, Type = "full", Source = "File")
}

\dontrun{
require(rentrez)
data <- rentrez::entrez_fetch(db = "Nucleotide", id = "508082122", rettype = "gb")
read.gb(File = data, DNA = TRUE, Type = "full", Source = "Char")
}

}
