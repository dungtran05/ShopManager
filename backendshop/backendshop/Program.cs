using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using backendshop.Data;
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<backendshopContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("backendshopContext") ?? throw new InvalidOperationException("Connection string 'backendshopContext' not found.")));

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();


app.UseSwagger();
app.UseSwaggerUI();

app.UseCors(opt =>
{
    opt.AllowAnyHeader();
    opt.AllowAnyOrigin();
    opt.AllowAnyMethod();
});

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
