using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backendshop.Migrations
{
    /// <inheritdoc />
    public partial class _21736usha : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsTrendy",
                table: "Product",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsTrendy",
                table: "Product");
        }
    }
}
