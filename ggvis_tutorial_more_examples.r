# #################################################################################
#                               
#                                ggvis Tutorial
# 
# #################################################################################

# Tutorial has been developed by Leslie McIntosh (dataschemata.com)
# This ggvis  tutorial is based on the notes on the following link, 
# written by Hadley Wickham: http://ggvis.rstudio.com/ggvis-basics.html

###################################################################################
# Useful things to know with ggvis:
 ?marks #lists the properties

###################################################################################

#Call to ggvis
library("ggvis")

#First element is the dataset (e.g., mtcars), the other elements are how to plot the data
p <- ggvis(mtcars, x = ~wt, y = ~mpg)

#Add code to actually plot the data.
#Note - outside of RStudio, this will be rendered in a web browser.
layer_points(p)


# OR
# Use the following code. 

mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_points()

# OR, equivalently as the first two arguments are typically the positions. 
# (Although, I prefer to explicitly state the x & y as in the previous code)

mtcars %>%
  ggvis(~wt, ~mpg) %>%
  layer_points()

# NOTES: The %>% (called 'pipe') from the magrittr packaged (http://cran.r-project.org/web/packages/magrittr/magrittr.pdf)
# allows to write more readable code, which is especially helpful when nested code.
# "The semantics of magrittr yield clean and readable code which can be read from
# left to right, rather than from the inside and out (which is the case with nested function calls), and
# reduce the need for temporary value bindings."


#Data can be manipulated using pipes
library(dplyr)
mtcars %>%
  ggvis(x = ~mpg, y = ~disp) %>%
  mutate(disp = disp / 61.0237) %>% # convert engine displacement to litres
  layer_points()

# Other variables can be added using 'fill', 'stroke', 'size', and 'shape'
mtcars %>%
  ggvis(x=~wt, y=~mpg, fill= ~gear) %>%
  layer_points()

# To fix elements (e.g., color, opacity, size, shape, stroke)  use := instead of =   

mtcars %>%
  ggvis(x=~wt, y=~mpg, fill= ~gear, opacity := 0.5, size := 300) %>%
  layer_points()

# Make this interactive by connecting variables to interactive controls
mtcars %>% 
  ggvis(~wt, ~mpg, fill= ~gear,
        size := input_slider(10, 100),
        opacity := input_slider(0, 1)
  ) %>% 
  layer_points()


#Another example
mtcars %>% 
  ggvis(~wt) %>% 
  layer_histograms(binwidth = input_slider(0, 2, step = 0.1))

#As well as input_slider(), ggvis provides input_checkbox(), input_checkboxgroup(), 
# input_numeric(), input_radiobuttons(), input_select() and input_text(). See the documentation
# for more examples using ? before any of the functions (e.g., ?input_slider() will give you 
# the documentation).

mtcars %>% 
  ggvis(~wt, ~mpg, fill= ~gear,
        size := input_slider(10, 100),
        opacity := input_slider(0, 1)
  ) %>% 
  layer_points()

# Example demonstrating layer_ribbons() and axis orientation: first, with a third variable - y2:

df <- data.frame(x = 1:12, y = runif(12))
df %>% ggvis(x = ~x, y = ~y, y2 = ~y - 0.1) %>% layer_ribbons() %>%
  add_guide_axis("x", title = "Days", orient = "top") %>%
  add_guide_axis("y", title = "Quantity Before and After Procedure", orient = "right", title_offset = 50)

# Another example with layer_ribbons, but now without a third variable - y2
df <- data.frame(x = 1:12, y = runif(12))
df %>% ggvis(x = ~x, y = ~y) %>% layer_ribbons() %>%
  add_guide_axis("x", title = "Days", orient = "top") %>%
  add_guide_axis("y", title = "Quantity Before and After Procedure", orient = "right", title_offset = 50)

# Example demonstrating multiple layers, more input controls and labeling them

mtcars %>% 
  ggvis(~wt, ~mpg) %>% 
  layer_points(fill = ~gear, size := input_slider(10, 100, label = "Point Size")) %>%
  layer_smooths(stroke = input_select(choices = c("Blue" = "blue", "Red" = "red", "Purple" = "purple"),selected = "Blue", label = "Line Color"), 
                span = input_slider(0.2, 1, value = 0.75, label = "Line Span")) %>%
  add_guide_legend( fill = "fill", title = "Gear", stroke = "stroke") 

#Example demonstrating layer_model_predictions and radio buttons.

mtcars %>% ggvis(~wt, ~mpg) %>%
  layer_model_predictions(model = input_radiobuttons(
    choices = c("Linear" = "lm", "LOESS" = "loess"),
    selected = "loess",
    label = "Model type"))

#Example demonstrating groupig variables by color and then adding smoothers
ChickWeight %>% 
  ggvis(x = ~Time, y = ~weight, fill = ~factor(Diet)) %>% 
  layer_points() %>% 
  group_by(Diet) %>% 
  layer_model_predictions(model="lm", stroke = ~factor(Diet))

