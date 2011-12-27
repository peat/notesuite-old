## NoteSuite

I don't expect this to be particularly useful to anyone else, but if by chance you happen to be a web developer who also collects world banknotes ... this might be right up your alley! The goal of NoteSuite is to simply track all of the data in my collection, so that I can more easily figure out what I have and what I'm missing.  

A bunch of real data for my collection can be found in the `data/current.sql` file.

A couple quick notes:

* This app was ported from Rails 1.2 ... so watch out for little pockets of old skool.
* I use PostgreSQL views to feed data to the `NoteCatalog` and `MasterCatalog` models. Beware.
* There's a hot little form builder in `helpers/application_form_builder.rb` ... check out some of the form ERB, and then see how it renders in the browser. Neat, 'eh?

Thanks for playing.
