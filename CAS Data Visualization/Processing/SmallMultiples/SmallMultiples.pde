import processing.pdf.*;
import org.gicentre.utils.stat.*;   
import java.util.*; 

int rectsize = 200;
int speed = 10;
int posX;
int posY;
Table table;

XYChart lineChart;
HashMap<Integer, String> allCountries;


void loadCountries()
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
}

void setup()
{
  //size(600,600);
  
  fullScreen();
  background(0);
  
  loadCountries();
  
  
  textSize(14);
  drawAllCountries();
}

void drawAllCountries()
{
  for(int i=1; i<150; i++)
  {
    drawCountries(i); //<>//
    drawCountry(i, i);
    String currentCountry = allCountries.get(i);
    text(currentCountry, posX+10, posY+10);
  
    posX += rectsize;
    if(posX >= width){
        posY += rectsize;
        posX=0;
    }
  }
}

void drawCountry(int index, int which)
{

  String currentCountry = allCountries.get(index);
  
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
 //<>//
  // Symbol colours
  lineChart.setPointSize(0);
  lineChart.setLineWidth(2);
  int alpha = 40;
  if(which == index)
  {
    alpha = 255;
  }
  lineChart.setLineColour(alpha);
  lineChart.setPointColour(255);
  
  
  lineChart.draw(posX, posY, rectsize, rectsize);
}

void drawCountries(int which)
{
  
  for(int i = 1; i<allCountries.size(); i++)
  {
    drawCountry(i, which);
  }
}


void draw()
{

}