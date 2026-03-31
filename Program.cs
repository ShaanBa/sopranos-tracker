using System;
using MySql.Data.MySqlClient;

// connection string this is setting up how its going to connect to the MySql db 
string connstr = "server=localhost;database=sopranos;user=root;password=;";

// using in this context is like with in python i assume like we used with in my 
// db client because with a context manager it allowed us to not worry about leaking info
// closing the conn automatically
using (var connection = new MySqlConnection(connstr))
{
    try // anything can happen working on a connection so do it in a try catch with
    {
        connection.Open();  // maybe this is like in psycopg2 the cursor that the connection uses to do work
        Console.WriteLine("Connected!"); // write some random shtiff 
    }

    catch (MySqlException ex) // if there is a mysql exception output it
    {
        Console.WriteLine($"Error: {ex.Message}");
    }
}

public class Family
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public required string BaseCity { get; set; }
}

public class Crew
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public required string Capo { get; set; }
    public int FamilyID { get; set; }

}

public class Mobster
{
    public int Id { get; set; }
    public required string FirstName { get; set; }
    public required string LastName { get; set; }
    public string? Moniker { get; set; }
    public required string Rank { get; set; }
    public required string Status { get; set; }
    public int CrewID { get; set; }

}

public class KnownAssociate
{
    public int Id { get; set; }
    public required string FirstName { get; set; }
    public required string LastName { get; set; }
    public required string RelationType { get; set; }
    public int MobsterId { get; set; }

}

public class BusinessFront
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public required string Industry { get; set; }
    public required string StreetAddress { get; set; }
}

public class CollectionLog
{
    public int Id { get; set; }
    public float Amount { get; set; }
    public DateTime DateCollected { get; set; }
    public int MobsterID {get; set; }
    public int BusinessID { get; set; }
    
}

