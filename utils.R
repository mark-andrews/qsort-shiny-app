# a function to define the "group" object
max_limit_group_opts <- function(name, limit){
  f_str <- "function(to) {{return to.el.children.length < {K};}}"
  
  sortable_options(
    group = list(
      name = name,
      put = htmlwidgets::JS(stringr::str_glue_data(.x = list(K = limit), f_str))
    )
  )
}


# make the html <style> code
make_grid_css <- function(k){
  
  s <- stringr::str_glue_data(.x = list(k = k),
  "
      .grid-container {{
        display: grid;
        grid-template-columns: repeat({k}, 1fr);
        grid-gap: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        background-color: #f9f9f9;
        margin-top: 20px;
      }}
      .grid-item {{
        background-color: lightgrey;
        border: 1px solid #ccc;
        padding: 0px;
        margin: 5px;
        width: 75px;
        text-align: center;
        font-size: 0.5em;
        cursor: move; /* Change cursor to indicate draggable items */
      }}
    ")
  
  tags$style(HTML(s))
}

make_grid_js <- function(id){
  sortable_js("my-grid-container", 
              options = sortable_options(
                group = 'my_shared_group',
                animation = 150, 
                ghostClass = "sortable-ghost"
              )
  )
}

make_grid <- function(items, id) {
  tags$div(
    id = id,
    class = "grid-container",
    purrr::map(items, ~tags$div(class = "grid-item", .))
    )
}


read_items <- function(filename){
  unlist(yaml::read_yaml('qsort_items.yaml'))
}


make_qsort_funnel_row <- function(width, input_id, group, limit, offset=1){
  fluidRow(
    column(
      width = width,
      offset = offset,
      rank_list(
        labels = c(),
        input_id = input_id,
        orientation = 'horizontal',
        options = max_limit_group_opts(name = group, limit = limit)
      ))
  )
}