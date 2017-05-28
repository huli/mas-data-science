
import java.util.*; 


Table table;

void setup()
{
    ArrayList list = new ArrayList();
    list.add("Switzerland");
    list.add("Poland");
    list.add("Poland");
    list.add("French");
    list.add("Switzerland");
    
    
    Set<String> set = new HashSet<String>(list);
    println("Unique countries count: " + set.size());
    
      
    table = loadTable("ef_per_capita.csv", "header");
    
    
     printCountry("Armenia"); 
}

void printCountry(String nameofCountry)
{
    //for(TableRow row : table.rows())
    //{
    //  String country = row.getString("country");
    //  if(country.equals(nameofCountry)) //<>//
    //  {
    //    println(row.getString("total"));
    //  } //<>//
    //}
    
    ArrayList<Float> years = new ArrayList<Float>();
    
    for (TableRow row : table.findRows(nameofCountry, "country")) {
      println(row.getString("country") + ": " + row.getString("total"));
      years.add(row.getFloat("total"));
    }
    
    for( v : years)
    {
       println(v);
    }
}