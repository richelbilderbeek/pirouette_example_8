# Works under Linux and MacOS only

library(pirouette)
suppressMessages(library(ggplot2))

################################################################################
# Constants
################################################################################
is_testing <- is_on_travis()
example_no <- 8
rng_seed <- 314
folder_name <- paste0("example_", example_no, "_", rng_seed)

################################################################################
# Create phylogeny
################################################################################
set.seed(rng_seed)
phylogeny <- create_yule_tree(n_taxa = 6, crown_age = 10)

################################################################################
# Setup pirouette
################################################################################
pir_params <- create_std_pir_params(
  folder_name = folder_name
)
stop("Remove generative")

# Shorter on Travis
if (is_testing) {
  pir_params <- shorten_pir_params(pir_params)
}

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

utils::write.csv(
  x = errors,
  file = file.path(folder_name, "errors.csv"),
  row.names = FALSE
)

pir_plot(errors) +
  ggsave(file.path(folder_name, "errors.png"), width = 7, height = 7)

pir_to_pics(
  phylogeny = phylogeny,
  pir_params = pir_params,
  folder = folder_name
)

pir_to_tables(
  pir_params = pir_params,
  folder = folder_name
)
