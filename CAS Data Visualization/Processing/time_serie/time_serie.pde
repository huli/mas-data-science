import org.gicentre.utils.stat.*;   
import java.util.*; 
 
 
XYChart lineChart;
HashMap<Integer, String> allCountries;

Table table;
 
void setup()
{
 
  // Load the data
  table = loadTable("ef_per_capita.csv", "header");
  
  // Make distinct list of all countries
  allCountries = new HashMap<Integer, String>();
  int indexOfCountry = 1;
  for(TableRow row : table.rows())
  {
      String country = row.getString("country");
      if(!allCountries.containsValue(country))
      {
        allCountries.put(indexOfCountry, country);
        indexOfCountry++;
      }
  }

  size(1800,1000);
  textFont(createFont("Lucida Console", 16), 16);
  
  background(backgroundColor);
  
  resetCanvas();
  
}

void drawAxisLabels()
{
  fill(foregroundColor);
  textSize(20);
  text("0", 20, height - 25);
  text("15", 20, 130);
  text("2010", width - 140, height - 25);
}
 
// Draws the chart and a title.
void draw()
{
  
}


int backgroundColor = 30;


void mouseClicked()
{
  // Draw a title over the top of the chart.
  drawNextCountry();
}

int currentCountryIndex = 1;

int foregroundColor = 240;

void drawTransparent()
{;
    fill(backgroundColor, 100);
    rect(0,0, width, height);
}

void resetCanvas()
{  
  drawTransparent();
  drawAxisLabels();
  
  // Draw a title over the top of the chart.
  fill(255);
  textSize(40);
  text("the ecological footprint", 80, 80);
  textSize(18);
  text("the footprint of countries measured in hectares per person", 
        80, 120); 
        
  fill(backgroundColor);
  rect(width - 600, 40, 600, 200);
  fill(foregroundColor);
}
void drawCountry(Integer countryIndex)
{
  
  resetCanvas();
  
  textSize(20);
  String currentCountry = allCountries.get(currentCountryIndex);
  if(currentCountry.equals("Congo"))
  {
    currentCountryIndex = currentCountryIndex + 1;
    drawCountry(currentCountryIndex);
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
  
  // Both x and y data set here.  
  lineChart = new XYChart(this);
  
  lineChart.setData(arrYears, arrTotals);
   
  // Axis formatting and labels.
  //lineChart.showXAxis(true); 
  //lineChart.showYAxis(true); 
  lineChart.setAxisLabelColour(2);
  lineChart.setMinY(0);
  lineChart.setMaxY(17);
  lineChart.setMinX(1961);
  lineChart.setMaxX(2013);
  
  println(currentCountry);
     
  lineChart.setYFormat("#,###");  // Hectares
  lineChart.setXFormat("0000");      // Year
   
  // Symbol colours
  // lineChart.setPointColour(color(255,50,50,100));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
  
  lineChart.draw(15, 0, width - 20, height - 20);
  
  
  textSize(22);
  text(currentCountry, width - 400, 80);

}

void drawNextCountry()
{
  
  drawCountry(currentCountryIndex);
  
  currentCountryIndex++;
  if(currentCountryIndex > allCountries.size())
  {
      currentCountryIndex = 1;
  }         //<>//
}