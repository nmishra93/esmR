ids_vector <-
    jsonlite::fromJSON(here::here(
        "data",
        "example.json"
    )) |>
    unnest(alignments) |>
    pull(target)
