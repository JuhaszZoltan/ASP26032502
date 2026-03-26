# ASP.NET Core WebAPI

### stack: [.NET 10, SQL Server, SwaggerUI]

## database

helyezd a `~/Data` mappába a `.db` file-t, és futtasd az `(localdb)\MSSQLLocalDB` serveren.

## packages

a következő csomagokra lesz szükség (`Package Manager Console`):
```powershell
Install-Package Microsoft.EntityFrameworkCore
Install-Package Microsoft.EntityFrameworkCore.SqlServer
Install-Package Microsoft.EntityFrameworkCore.Tools
Install-Package Swashbuckle.AspNetCore.SwaggerUI
```

## database connection

default connection string beállítása (`appsettings.json`)
```json
...
"ConnectionStrings": {
    "DefaultConnection": "server=(localdb)\\mssqllocaldb;database=zoo;"
  },
...
```

## models + ORM context scaffold

futtasd le a következő utasítást a `Package Manager Console`-ban

```powershell
Scaffold-DbContext "Name=ConnectionStrings:DefaultConnection" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -DataAnnotations -Context ApplicationDbContext -ContextDir Data
```

