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
  textFont(createFont("Arial",16),16);
  background(255);
  textSize(14);
}
 
// Draws the chart and a title.
void draw()
{
  
}

void mouseClicked()
{
  drawCountry();
}

int currentCountryIndex = 1;

void drawCountry()
{
  
  String currentCountry = allCountries.get(currentCountryIndex);
  
  
  ArrayList<Float> totalsPerYear = new ArrayList<Float>();
  ArrayList<Float> years = new ArrayList<Float>();
  
  for (TableRow row : table.findRows(currentCountry, "country"))  //<>//
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
  lineChart.setMinY(0);
     
  lineChart.setYFormat("###,###");  // Hectares
  lineChart.setXFormat("0000");      // Year
   
  // Symbol colours
  lineChart.setPointColour(color(180,50,50,100));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
  
  lineChart.draw(15,15,width-30,height-30);
   
  // Draw a title over the top of the chart.
  fill(120);
  textSize(40);
  text("EF per Capita", 70,30);
  textSize(18);
  text("Ecological Footprint per Capita measured in hectares", 
        70, 60);
}