# Nitesh Mishra
# This R script requires certain libraries to be installed for proper functioning.
# The list of required libraries is stored in the 'libs' vector.

# Libraries needed to run this particular project
libs <- c(
    "here",
    "httr",
    "tidyverse",
    "jsonlite"
)

# The function 'check_libs' is designed to check whether the required libraries are installed.
# If a library is not installed, it installs the library using 'install.packages' and loads it with 'library'.

# Function to test if the required libraries are installed, and if not
# installed, then install them.
check_libs <- function(libs) {
    # Define a function to check and install libraries
    check_and_install <- function(lib) {
        if (!require(lib, character.only = TRUE)) {
            install.packages(lib, dependencies = TRUE)
            library(lib, character.only = TRUE)
        }
    }

    # Use lapply to apply the check_and_install function to each library
    lapply(libs, check_and_install)
    invisible()
}

# Call the check_libs function with the list of required libraries
check_libs(libs)
