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
  
  background(0);
}
 
// Draws the chart and a title.
void draw()
{
  
}

void mouseClicked()
{
  // Draw a title over the top of the chart.
  drawNextCountry();
}

int currentCountryIndex = 1;

void resetCanvas()
{  
  
  background(0);
  
    // Draw a title over the top of the chart.
  fill(255);
  textSize(40);
  text("the ecological footprint", 70, 80);
  textSize(18);
  text("the footprint of countries measured in hectares per person", 
        70, 120); 
  textSize(20);
}
void drawCountry(Integer countryIndex)
{
  
  resetCanvas();
  
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
  lineChart.showXAxis(true); 
  lineChart.showYAxis(true); 
  lineChart.setAxisLabelColour(2);
  lineChart.setXAxisLabel(currentCountry);
  lineChart.setMinY(0);
  lineChart.setMaxY(17);
  lineChart.setMinX(1961);
  lineChart.setMaxX(2013);
  
  println(currentCountry);
     
  lineChart.setYFormat("#,###");  // Hectares
  lineChart.setXFormat("0000");      // Year
   
  // Symbol colours
  lineChart.setPointColour(color(180,50,50,100));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
  
  lineChart.draw(20, 0, width - 20, height);
  
  text(currentCountry, width - 280, 80);
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