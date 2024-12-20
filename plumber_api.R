# Load required packages
library(plumber)
library(dplyr)
library(glue)
library(gargle)
library(rmarkdown)
library(googleCloudStorageR)
library(tools)

# Load environment variables from .env if it exists
bucket <- Sys.getenv("GCS_BUCKET_NAME", "portal_to_box")

# Define config ----------------------------------------------------------------
report_config <- tribble(
  ~code,  ~box_folder_id, ~rmd_name,                      ~pdf_name,
  "iris", "299557439792", "report_iris.Rmd",              "Iris_Summary_Statistics.pdf",
  "peng", "299558308044", "report_penguins.Rmd",          "The_Penguin_Report.pdf",
  "part", "299555190551", "report_participant_count.Rmd", "Participant_Count_Report.pdf"
)

# Global Decorators ------------------------------------------------------------
#* @apiTitle Demo pipeline API
#* @apiDescription Plumber API for generating and uploading reports.

# Endpoint A -------------------------------------------------------------------
#* Heartbeat endpoint for testing
#* @get /heartbeat
function() {
  msg <- "API is alive!"
  message(msg)
}

# Endpoint B -------------------------------------------------------------------
#* Generate report and upload to GCS
#* @param report_code:string The code of the report as specified in the config
#* @get /render_rmd_report
function(report_code) {
  
  # Get the configuration associated with the report code
  cfg <- report_config %>% filter(code == report_code)
  
  # Generate a unique PDF filename
  date_stamp <- format(Sys.time(), "%m_%d_%Y")
  base_name  <- tools::file_path_sans_ext(cfg$pdf_name)
  pdf_name   <- glue::glue("{base_name}_{date_stamp}_boxfolder_{cfg$box_folder_id}.pdf")
  
  # Render the RMarkdown file
  rmarkdown::render(cfg$rmd_name, output_format="pdf_document", output_file=pdf_name)
  
  # Authenticate with Google Cloud Storage
  scope <- c("https://www.googleapis.com/auth/cloud-platform")
  token <- gargle::token_fetch(scopes = scope)
  googleCloudStorageR::gcs_auth(token = token)
  
  # Upload .csv and .pdf files to GCS
  filelist <- list.files(pattern = "\\.(csv|pdf)$")
  lapply(filelist, function(x) {
    googleCloudStorageR::gcs_upload(x, bucket = bucket, name = x)
    print(glue::glue("Uploaded file: {x}"))
  })
  
  print(glue::glue("All done. Check {bucket} for {pdf_name}"))

}
