namespace SopranosDashboard.Models;
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
    public float TotalCollected {get; set;}

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
    public float TotalCollected { get; set; }
}

public class CollectionLog
{
    public int Id { get; set; }
    public float Amount { get; set; }
    public DateTime DateCollected { get; set; }
    public int MobsterID {get; set; }
    public int BusinessID { get; set; }

    public string? MobsterFirstName { get; set;}
    public string? MobsterLastName { get; set; }
    public string? FrontName { get; set; }
    
}

