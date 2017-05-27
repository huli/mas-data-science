import org.gicentre.utils.stat.*;    
 
XYChart lineChart;


 
// Loads data into the chart and customises its appearance.
void setup()
{
  
  //Table table = loadTable("ef_per_capita.csv", "header");
  
  //for(TableRow row : table.rows())
  //{
  //  println(row.getString("country"));
  //}
  
  
  size(1800,1000);
  textFont(createFont("Arial",16),16);
 
  // Both x and y data set here.  
  lineChart = new XYChart(this);
  lineChart.setData(new float[] {1900, 1910, 1920, 1930, 1940, 1950,
                                  1960, 1970, 1980, 1990, 2000},
                    new float[] { 6322,  6489,  6401, 7657, 9649, 9767,
                                  12167, 15154, 18200, 23124, 28645});
   
  // Axis formatting and labels.
  lineChart.showXAxis(true); 
  lineChart.showYAxis(true); 
  lineChart.setMinY(0);
     
  lineChart.setYFormat("###,###");  // Monetary value in $US
  lineChart.setXFormat("0000");      // Year
   
  // Symbol colours
  lineChart.setPointColour(color(180,50,50,100));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
}
 
// Draws the chart and a title.
void draw()
{
  background(255);
  textSize(14);
  
  drawCountry();
}

void drawCountry(){
  
  lineChart.draw(15,15,width-30,height-30);
   
  // Draw a title over the top of the chart.
  fill(120);
  textSize(40);
  text("EF per Capita, United Kingdom", 70,30);
  textSize(18);
  text("Ecological Footprint per Capita measured in hectares", 
        70, 60);
}