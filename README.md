# tiedye - A High-Level Image Processing and Color Library for Ruby

tiedye uses ruby-vips to provide a fast and easy means for manipulating image
files.

  # This will read a jpeg, fit it into a 140x123 box, and write it out as a png
  Image.read('my.jpg').fit(140, 123).write('my.png')

  # This will read in two files and write them out a a single sprite file.
  sprite = Image.sprite('button.png', 'frame.png')
  sprite.write('sprite.png')

  # Sprites are generated by stacking. You can get more information on
  # positioning:
  sprite.placements # => { 