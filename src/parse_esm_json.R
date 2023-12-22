ids_vector <-
    jsonlite::fromJSON(here::here(
        "3EGM_esmatlas_seq_search.json"
    )) |>
    unnest(alignments) |>
    pull(target)
