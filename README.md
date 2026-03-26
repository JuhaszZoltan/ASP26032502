# ASP.NET Core WebAPI

### stack: [.NET 10, SQL Server, SwaggerUI]

## database

helyezd a `~/Data` mappába a `.sql` scriptfile-t, és futtasd az `(localdb)\MSSQLLocalDB` serveren.

## packages

a következő csomagokra lesz szükség (`Package Manager Console`):
```ps
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
    "DefaultConnection": "server=(localdb)\\mssqllocaldb;database=<database_name>;"
  },
...
```

## scaffold models and database context

futtasd le a következő utasítást a `Package Manager Console`-ban

```ps
Scaffold-DbContext "Name=ConnectionStrings:DefaultConnection" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -DataAnnotations -Context ApplicationDbContext -ContextDir Data
```

## scaffold API Controllers

`~/Controllers/Api/` mappa környezeti menüjében `Add > New Scaffolded Item >` az 'Add New Scaffolded Item' ablakban válaszd ki a `Common > API > [API Controller with actions, using Entity Framework]`, az 'Add API Controller with actions, using Entity Framework' ablakban válaszd ki a következőket:
- `Model class: ` <- annak a modelnek a neve, amihez a REST action-öket szeretnéd beállítani
- `DbContext class: ` <- az előző lépésben scaffoldolt context osztály (`ApplicationDbContext`)
- `Controller name: ` <- Konvenció szerint Pascal case, model neve többesszámban + Controller (ez az alapértelmezett javaslat)

> **[2026-03-26 állapot szerint]:** a Visual Studio 2026 már nem támogatja alapértelmezetten a SwaggerUI-t. van egy built-in tool, az Endpoint Explorer, de komoly problémákat tapasztalok vele, és messze nem olyan intuitív. A Swagger re-implementációját vagy valamilyen alternatíva használatát javaslom API tesztre vagy API dokumentáció készítésére: Postman, Scalar vagy Redoc [csak dokumentációhoz]))

## fix action-method annotations (for Swagger)

