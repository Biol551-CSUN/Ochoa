### Today I will be working with words using strings
### Created by Ashlee Ochoa 
### Created on 2022-04-19

### Loading Libraries 
library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

# Manipulation 
paste("High temp", "Low pH") ### Paste words or columns together
paste("High temp", "Low pH", sep = "-") ## sep using -
paste0("High Temp", "Low pH") # no spave in between 

  # Working with vectors
shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes)

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")

  # Individual characters 
shapes # vector of shapes 

str_length(shapes) # how many letters are in each word?

seq_data <- ("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA

str_sub(seq_data, start = 3, end = 3) <- "A" # add an A in the 3rd position
seq_data

# can also duplicate data 
str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string


# Whitespace
badtreatments<-c("High", " High", "High ", "Low", "Low") ## contains spaces 
badtreatments

str_trim(badtreatments) # removes white space

str_trim(badtreatments, side = "left") # this removes left. Chose to remove left side 

str_pad(badtreatments, 5, side = "right") # add a white space to the right side after the 5th character

str_pad(badtreatments, 5, side = "right", pad = "1") # add a 1 to the right side after the 5th character

# Locale Sensitive 
x<-"I love R!"
str_to_upper(x)  ## make it uppercase

str_to_lower(x) ## make it uppercase 

str_to_title(x) # Cap first letter of each word 

# Pattern Matching 
data<-c("AAA", "TATA", "CTAG", "GCTT")
str_view(data, pattern = "A") # find all strings with an A 

str_detect(data, pattern = "A") ## function to detect 
str_detect(data, pattern = "AT")

str_locate(data, pattern = "AT") ## locate a pattern 

# regex: regular expressions 
# Several types of regular expressions 
  # metacharacters, sequences, quantifiers, character classes, POSIX character classes (Portable Operating System Interface) 

# Metacharacters 
vals<-c("a.b", "b.c","c.d")

str_replace(vals, "\\.", " ") # replace "." with space. use string replace. first thing is what youre searching for, escaping the area it is in
 # This only replaces the first instance 

vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ")
str_replace_all(vals, "\\.", " ") #replace all instances 

# Sequences 
# also use escapes 
val2<-c("test 123", "test 456", "test")
# subset vectors that have a digit within them 
str_subset(val2, "\\d")

# Character Class 
str_count(val2, "[aeiou]") ## count the numbers of vals 
# count any digit
str_count(val2, "[0-9]")

# Find the phone number 
strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
# Which strings contain phone numbers?
str_detect(strings, phone)

# subset only the strings with phone numbers
test<-str_subset(strings, phone)

test %>%
  str_replace_all(pattern = "\\.", replacement = "-") %>% # replace periods with -
  str_replace_all(pattern = "[a-zA-Z]|\\:", replacement = "") %>% # remove all the things we don't want
  str_trim() # trim the white space

# Tidytext
# explore it
head(austen_books()) # analyze book 
tail(austen_books())

Original_books <- austen_books() %>%  # get all of Jane Austen's books 
  group_by(book) %>% 
  mutate(line = row_number(), # find every line 
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", # count the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>% ##ignore lower or uppercase
  ungroup() # ungroup it so we have a dataframe again
head(Original_books)

tidy_books <- Original_books %>%
  unnest_tokens(output = word, input = text) # add a column named word, with the input as the text column
head(tidy_books) # there are now >725,000 rows. Don't view the entire thing!

#see an example of all the stopwords
head(get_stopwords())

cleaned_books <- tidy_books %>%
  anti_join(get_stopwords()) # dataframe without the stopwords

head(cleaned_books)

cleaned_books %>% 
  count(word, sort = TRUE)

sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them

sent_word_counts %>%
  filter(n > 150) %>% # take only if there are over 150 instances of it
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% # add a column where if the word is negative make the count negative
  mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")

words<-cleaned_books %>%
  count(word) %>% # count all the words
  arrange(desc(n))%>% # sort the words
  slice(1:100) #take the top 100
wordcloud2(words, shape = 'triangle', size=0.3) # make a wordcloud out of the top 100 words
