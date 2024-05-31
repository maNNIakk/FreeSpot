using Microsoft.EntityFrameworkCore;

namespace FreeSpot.Data
{
    public class ApplicationDbContext : DbContext
    {
        // DbSet for each entity that you want to include in the database
        public DbSet<WeatherForecast> WeatherForecasts { get; set; }

        // Constructor to initialize the context with options
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        // You can optionally override OnModelCreating to further configure your model
        // protected override void OnModelCreating(ModelBuilder modelBuilder)
        // {
        //     // Configure your entities here
        // }
    }
}
