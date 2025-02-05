# Purpose: Intro to R demo - tables and plots
# Date: 27th Jan, 2025
# Contact: meenakshi.kushwaha@gmail.com


# load packages -----------------------------------------------------------

pacman::p_load(
  here,        # set file path
  rio,         # import/export data
  tidyverse,   # clean and analyze data
  flextable    # publication ready tables
)


# load data ---------------------------------------------------------------

my_data <- import(here("data", "clean.csv"))

# tables ------------------------------------------------------------------

# create a summary table by District
my_table <- my_data %>% 
  group_by(id_district) %>% 
  summarise(
    n = n(), 
    min = min(bll_c_num),
    max = max(bll_c_num),
    median = median(bll_c_num),
    mean = mean(bll_c_num),
    qntl_95 = quantile(bll_c_num, 0.95)
  )


# Pass the summary table data frame to flextable for publication ready tables
my_table %>% 
  flextable() %>% 
  colformat_double(digits = 1) %>%          # convert all numeric columns to 1 sig digit
  align_nottext_col(align = "center") %>%   # center align all numeric columns
  set_header_labels(id_district = "District") %>%           # Change column name
  set_caption("BLL Distribution by district (ug/dL)") %>%   # Add title 
  save_as_docx(path = here("tables", "summary_table.docx")) # save as word file


# plots -------------------------------------------------------------------

# Create a plot using ggplot
# Note that ggplot syntax uses "+" instead of "%>%"

ggplot(my_data) +  
  geom_histogram(aes(x=bll_c_num, fill = area_type)) +
  theme_minimal() +
  labs(
    x = "BLL (ug/dL)",
    y = "Number of Children", 
    title = "Blood Lead Level (BLL) Distribution of Children ",
    caption = "Source: 2023 Pb Survey"
  )

# Save the most recent plot with today's date
ggsave(here("plots", paste0(Sys.Date(),"_my_plot.jpeg")))
