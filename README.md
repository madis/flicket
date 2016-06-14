# Flicket

Flicket is a ruby command line tool that:

* accepts a list of search keywords as arguments
* queries the Flickr API for the top-rated image for each keyword
* downloads the results
* crops them rectangularly
* assembles a collage grid from ten images and
* writes the result to a user-supplied filename

If given less than ten keywords, or if any keyword fails to
result in a match, retrieve random words from a dictionary
source such as `/usr/share/dict/words`. Repeat as necessary
until you have gathered ten images.

Be careful and conservative in your handling of files and
other IO. Bonus points for wrapping the application in a
Gem. Please include a README with instructions on how to
install and run your application.

Hint: You're free to use any existing Gem which helps you to
get the challenge done

## Installation

```
git clone https://github.com/madis/flicket.git
cd flicket
bundle install
rake build
gem install pkg/flicket.gem
```


## Usage

After building and installing the gem:

`flicket [keyword ...]`

Or inside the gem source folder (after installing dependencies with `bundle install`):

`./bin/flicket [keyword ...]`
