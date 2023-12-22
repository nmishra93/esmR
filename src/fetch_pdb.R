# Function to make API request, save response, and print message
fetchAndSave <- function(id, file_extension, counter, total_files, rank, prefix = "esm") {
    # Define base URLs for PDB and FASTA requests
    pdb_base_url <- "https://api.esmatlas.com/fetchPredictedStructure/"
    fasta_base_url <- "https://api.esmatlas.com/fetchSequence/"

    # Construct the full URL based on the file extension
    if (file_extension == "pdb") {
        api_url <- paste0(pdb_base_url, id)
    } else if (file_extension == "fasta") {
        api_url <- paste0(fasta_base_url, id)
    } else {
        # Display error message for unsupported file extensions
        cat("Unsupported file extension:", file_extension, "\n")
        cat("Possible solutions: Use 'pdb' or 'fasta' as file extensions.\n")
        return(invisible())
    }

    tryCatch(
        {
            # Make the API request
            response <- httr::GET(api_url)

            # Extract MGY_ID from the URL
            MGY_ID <- tail(strsplit(api_url, "/")[[1]], 1)

            # Define the output file name
            output_file <- paste0(rank, "_", prefix, "_", MGY_ID, ".", file_extension)

            # Save the response to the specified file
            writeBin(content(response, "raw"), output_file, useBytes = TRUE)

            # Display success message
            cat("File saved as", output_file, "\n")

            Sys.sleep(sample(
                x = abs(
                    rnorm(
                        100, 0, 0.5
                    )
                ),
                size = 1
            ))

            # Increment the counter
            counter$downloaded_files <<- counter$downloaded_files + 1

            # Log the message
            cat("Progress: Downloaded file:", counter$downloaded_files, "out of", total_files, "\n")
        },
        error = function(e) {
            # Display error message for failed API requests
            cat("Error downloading file:", e$message, "\n")
            cat("Possible solutions: Check your internet connection or verify the API URL.\n")
        }
    )
}

# ESM IDs
esm_ids <- ids_vector[1:3]

# Initialize the counter and total files
counter <- list(downloaded_files = 1)
total_files <- length(esm_ids)


# Fetch and save PDB files
cat("Fetching and saving PDB files...\n")
for (i in seq_along(esm_ids)) {
    fetchAndSave(esm_ids[i], "pdb", counter, total_files, rank = i, prefix = "3EGM")
}

# Initialize the counter
counter <- list(downloaded_files = 1)

# Fetch and save FASTA files
cat("Fetching and saving FASTA files...\n")
for (i in seq_along(esm_ids)) {
    fetchAndSave(esm_ids[i], "fasta", counter, total_files, rank = i, prefix = "3EGM")
}
