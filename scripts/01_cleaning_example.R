# Purpose: Intro to R demo - data cleaning 
# Date: 27th Jan, 2025
# Contact: meenakshi.kushwaha@gmail.com

# load packages -----------------------------------------------------------

pacman::p_load(
  here,        # set file path
  rio,         # import/export data
  janitor,     # clean names
  tidyverse    # clean and analyze data
)

# load data ---------------------------------------------------------------

raw_data <- import(here("data", "example_raw_data.csv"))



# data cleaning -----------------------------------------------------------

clean_data <- raw_data %>% 
  clean_names() %>% 
  select(-v1)
  

clean_data %>% 
  group_by(id_district) %>% 
    summarise(
    n = n(), 
    min = min(bll_c_num),
    max = max(bll_c_num),
    median = median(bll_c_num),
    mean = mean(bll_c_num),
    qntl_95 = quantile(bll_c_num, 0.95)
  )
  
  

# other demo code ---------------------------------------------------------

# filter rows by district
raw_data %>% 
  clean_names() %>%  
  filter(id_district == "Patna") %>% 
  View()


# create a new column
raw_data %>% 
  clean_names() %>%  
  mutate(bll_high = ifelse(bll_c_num >= 5, TRUE, FALSE)) %>% 
  View()


  

  
