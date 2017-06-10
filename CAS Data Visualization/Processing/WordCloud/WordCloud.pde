import wordcram.*;

// Set up the Processing sketch
size(1800, 1200);
colorMode(HSB);
background(255);

// Make a wordcram from a random wikipedia page.
new WordCram(this)
  .fromWebPage("https://en.wikipedia.org/wiki/Special:Random")
  .withColors(color(30), color(110),
              color(random(255), 240, 200))
  .sizedByWeight(5, 120)
  .withFont("Copse")
  .drawAll();