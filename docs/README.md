**ESM Atlas Data Fetcher**

This R program facilitates seamless interaction with the Evolutionary Scale Modeling (ESM) Atlas API to retrieve predicted structures and sequences. Leveraging the power of the `httr` library, the tool efficiently makes HTTP requests to fetch Protein Data Bank (PDB) files and FASTA files based on specified ESM IDs. Whether you're exploring evolutionary structures or analyzing biological sequences, this program streamlines the data retrieval process, enhancing your research capabilities in structural bioinformatics.

The provided R program is designed to make API requests to retrieve predicted structures and sequences from the ESM (Evolutionary Scale Modeling) Atlas. The program fetches both PDB (Protein Data Bank) files and FASTA files for a given set of ESM IDs. It uses the `httr` library to handle HTTP requests.

Let's break down the code step by step:

### Function Definition: `fetchAndSave`

This function takes several parameters:
- `id`: The ESM ID for which the data is requested.
- `file_extension`: The type of file to be fetched ("pdb" for PDB files or "fasta" for FASTA files).
- `counter`: A list containing a counter for downloaded files.
- `total_files`: The total number of files to be downloaded.
- `rank`: The rank of the current file in the download queue.
- `prefix`: A prefix for the output file name (default is "esm").

#### Constructing API URLs

The function constructs the appropriate API URL based on the file extension ("pdb" or "fasta").

#### Making API Request

The function then uses `httr::GET` to make an HTTP GET request to the constructed API URL.

#### Handling the Response

Inside a `tryCatch` block, the function attempts to process the response. If successful, it extracts the MGY_ID from the URL, defines an output file name, saves the response to a binary file, and increments the counter.

#### Error Handling

If an error occurs during the API request, the function catches the error and displays an error message with possible solutions.

#### Sleeping Period

After each successful download, the program sleeps for a random duration (modeled by a normal distribution with a mean of 0 and standard deviation of 0.5). This introduces a delay before the next API request.

### Main Program

#### ESM IDs

An example vector of ESM IDs (`esm_ids`) is provided. It is assumed that the `ids_vector` is defined somewhere in the program, but it is not included in the provided code.

#### Counter Initialization

A counter is initialized to keep track of the number of downloaded files. The total number of files is determined by the length of the `esm_ids` vector.

#### Fetching and Saving PDB Files

A loop iterates over each ESM ID, calling the `fetchAndSave` function to download and save PDB files.

#### Fetching and Saving FASTA Files

A similar loop follows for FASTA files.

### Output and Messages

The program outputs messages to the console, indicating the progress of file downloads, success messages, and error messages.

### Note

It's important to note that the program assumes the existence of an `ids_vector` and the proper configuration of the ESM API URLs. Additionally, the use of `Sys.sleep` introduces a random delay, which might be useful to avoid overwhelming the server with too many requests in a short period. Adjustments to the sleep duration can be made based on specific requirements and server limitations.