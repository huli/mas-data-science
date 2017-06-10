import org.gicentre.utils.stat.*;    //<>//
import java.util.*; 


XYChart lineChart;
HashMap<Integer, String> allCountries;
Table table;
int speed = 1;
boolean record = false;
int backgroundColor = 30;
int currentCountryIndex = 1;
int foregroundColor = 240;

void setup()
{
  // Load the data
  table = loadTable("ef_per_capita.csv", "header");

  // Make distinct list of all countries
  allCountries = new HashMap<Integer, String>();
  int indexOfCountry = 1;
  for (TableRow row : table.rows())
  {
    String country = row.getString("country");
    if (!allCountries.containsValue(country))
    {
      allCountries.put(indexOfCountry, country);
      indexOfCountry++;
    }
  }

  fullScreen(); // size(1800, 1000);
  
  textFont(createFont("Lucida Console", 16), 16);
  background(backgroundColor);

  resetCanvas();
}

void keyPressed() {
  if (key == 'q') {
    exit();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  if (e > 0)
    speed = speed - 2;
  else
    speed = speed + 2;

  if (speed > 100)
    speed = 100;
  if (speed < -100)
    speed = -100;
}



void drawAxisLabels()
{
  fill(foregroundColor);
  textSize(20);
  
  float yheight = (height - 25 - 130) / 3;
  text("0", 20, height - 25);
  text("10", 20, yheight + 130);
  text("5", 20, yheight*2 + 130);
  text("15", 20, 130);
  text("2013", width - 80, height - 25);
}

// Draws the chart and a title.
void draw()
{
  if (record) {
    beginRecord(PDF, "frame-####.pdf"); 
  }
  
  drawCountry();
  incrementCountry();


  int waitTime;
  if (speed == 0)
    waitTime = 5000;
  else
    waitTime = 1000 / abs(speed);
    
  delay(waitTime);
}

void incrementCountry()
{
    if(speed > 0)
    currentCountryIndex++;
  else
    currentCountryIndex--;
    
  if (currentCountryIndex > allCountries.size())
  {
    currentCountryIndex = 1;
  }  
  
  if (currentCountryIndex < 1)
  {
    currentCountryIndex = allCountries.size();
  }  

}



void drawTransparent()
{
  fill(backgroundColor, 80);
  rect(0, 0, width, height);
}

void resetCanvas()
{  
  drawTransparent();
  drawAxisLabels();

  // Draw a title over the top of the chart.
  fill(255);
  textSize(40);
  text("the ecological footprint", 140, 80);
  textSize(18);
  text("the footprints of countries between 1961 and 2013, measured in hectares per capita", 
    140, 120); 

  noStroke();
  fill(backgroundColor);
  rect(width - 900, 55, 700, 50);
  fill(foregroundColor);
}

void drawCountry()
{

  resetCanvas();

  textSize(20);
  String currentCountry = allCountries.get(currentCountryIndex);

  if (currentCountry.equals("Congo"))
  {
    incrementCountry();
    drawCountry();
    return;
  }

  ArrayList<Float> totalsPerYear = new ArrayList<Float>();
  ArrayList<Float> years = new ArrayList<Float>();

  for (TableRow row : table.findRows(currentCountry, "country")) 
  {
    totalsPerYear.add(row.getFloat("total"));
    years.add(row.getFloat("year"));
  }

  float [] arrTotals = new float[totalsPerYear.size()];
  float [] arrYears = new float[years.size()];

  int i = 0;
  for (Float f : totalsPerYear) {
    arrTotals[i++] = (f != null ? f : Float.NaN); // Or whatever default you want.
  }

  i = 0;
  for (Float f : years) {
    arrYears[i++] = (f != null ? f : Float.NaN); // Or whatever default you want.
  }

  lineChart = new XYChart(this);
  lineChart.setData(arrYears, arrTotals);
  lineChart.setAxisLabelColour(2);
  lineChart.setMinY(0);
  lineChart.setMaxY(17);
  lineChart.setMinX(1961);
  lineChart.setMaxX(2013);
  lineChart.setYFormat("#,###");  // Hectares
  lineChart.setXFormat("0000");   // Year

  // Symbol colours
  lineChart.setPointSize(6);
  lineChart.setLineWidth(2);
  lineChart.setLineColour(255);
  lineChart.setPointColour(255);

  lineChart.draw(15, 0, width - 20, height - 20);

  textSize(24);
  textAlign(RIGHT);
  text(currentCountry, width - 200, 100);
  textAlign(LEFT);
}