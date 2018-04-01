# Gilded Rose Refactoring Kata

### Installation

This was an interesting and challenging test! In order to install and run the tests:
```
$ git clone git@github.com:l3w15/GildedRose-Refactoring-Kata.git
$ bundle install
$ rspec ruby/Spec -fd
```

### Approach and Structure

My first step was to write passing tests for the current code so that I could be sure that any refactor would not change the functionality of the update_quality method. Using doubles proved difficult at this stage so I just made a new Item for each test. I then pulled out various bits of functionality into separate methods, one to check the type of item (if not a 'normal item') and another to update the item's quality accordingly.

Having done this without altering the functionality, and reduced the update_quality method a great deal, I proceeded to separate out the various different items into their own classes, using a TDD approach. These tests were cleaner, only testing the Item in question. At a certain point it became clear that a BaseItem class would be useful, inheriting from Item, and with a method to age the item which would be called by the update_item method before updating the quality. Each other class could then inherit from BaseItem but with a separate update_item method which follow the same pattern but updating the quality according to the specifications for that item.

Once this stage was complete, it was easier to use doubles for each item in the tests for GildedRose #update_quality add the ConjuredItem class, and to refactor the code further, for example adding a check_item_type method which would use a hash lookup to check for maturing, legendary, conjured or deadline items.

[![Screen_Shot_2018-04-01_at_22.33.19.png](https://s6.postimg.org/fhq0y4qgh/Screen_Shot_2018-04-01_at_22.33.19.png)](https://postimg.org/image/3sm1a5zhp/)
