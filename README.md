# ASP.NET Core WebAPI

### stack: [.NET 10, SQL Server, SwaggerUI]

## database

helyezd a `~/Data` mappába a `<database_script_name>.sql` scriptfile-t, és futtasd az `(localdb)\MSSQLLocalDB` serveren.

## packages

a következő csomagokra lesz szükség (`Package Manager Console`):
```shell
Install-Package Microsoft.EntityFrameworkCore
Install-Package Microsoft.EntityFrameworkCore.SqlServer
Install-Package Microsoft.EntityFrameworkCore.Tools
Install-Package Microsoft.VisualStudio.Web.CodeGeneration.Design
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

```shell
Scaffold-DbContext "Name=ConnectionStrings:DefaultConnection" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -DataAnnotations -Context ApplicationDbContext -ContextDir Data
```

## scaffold API Controllers

`~/Controllers/Api/` mappa környezeti menüjében `Add > New Scaffolded Item >` az 'Add New Scaffolded Item' ablakban válaszd ki a `Common > API > [API Controller with actions, using Entity Framework]`, az 'Add API Controller with actions, using Entity Framework' ablakban válaszd ki a következőket:
- `Model class: ` <- annak a modelnek a neve, amihez a REST action-öket szeretnéd beállítani
- `DbContext class: ` <- az előző lépésben scaffoldolt context osztály (`ApplicationDbContext`)
- `Controller name: ` <- Konvenció szerint Pascal case, model neve többesszámban + Controller (ez az alapértelmezett javaslat)

## ORM service configuration

a `Program.cs`-ben az `// Add services to the container.` sor alá add hozzá a következő kódot:
```csharp
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found");
builder.Services.AddDbContext<ApplicationDbContext>(options => 
    options.UseSqlServer(connectionString));
```
a működéshez szükséges `using` direktívák:

```csharp
using <project_namespace>.Data;
using Microsoft.EntityFrameworkCore;
```

## setup SwaggerUI

> **[2026-03-26 állapot szerint]:** a Visual Studio 2026 már nem támogatja alapértelmezetten a SwaggerUI-t. van egy built-in tool, az Endpoint Explorer, de komoly problémákat tapasztalok vele, és messze nem olyan intuitív. A Swagger re-implementációját vagy valamilyen alternatíva használatát javaslom API tesztre vagy API dokumentáció készítésére: Postman, Scalar vagy Redoc [csak dokumentációhoz]))



## fix action-method attributes

> A scaffoldolt action method-ok HTTP verb attribútumai nem tartalmazzák az implicit módon a constaint route paraméterek típusát, ez endpointok Swaggeren való tesztelésénél problémát jelenthet, ezért ezeket kézzel kell javítani a következő három esetben:

| eredeti | módosított |
| :--- |  ---: |
| `[HttpGet("{id}")]` | `[HttpGet("{id:int}")]` |
| `[HttpPut("{id}")]` | `[HttpPut("{id:int}")]` |
| `[HttpDelete("{id}")]` | `[HttpDelete("{id:int}")]` |

> API-ok esetében az implicit típusmeghatározás egyébként is erősen ajánlott, függetlenül attól, hogy milyen eszközt használunk a teszteléshez.